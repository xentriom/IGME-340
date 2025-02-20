import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeWidget());
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final String _giphyUrl = "https://api.giphy.com/v1/gifs/";
  final String _giphyKey = "5PuWjWVnwpHUQPZK866vd7wQ2qeCeqg7";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchTermController = TextEditingController();
  String _searchAmount = '10';
  List<dynamic> _gifs = [];

  // set initial state
  @override
  void initState() {
    super.initState();
    _fetchTrendingGifs();
  }

  /// Reset the form and fetch trending GIFs
  void _resetForm() {
    _formKey.currentState!.reset();
    _searchTermController.clear();
    setState(() {
      _searchAmount = '10';
      _gifs.clear();
    });
    _fetchTrendingGifs();
  }

  /// Submit the form and search for GIFs
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final searchTerm = _searchTermController.text;
      _searchGifs(searchTerm, _searchAmount);
      _resetForm();
    }
  }

  /// Helper function to build the Giphy API URL
  String _buildUrl({
    required searchTerm,
    String searchAmount = '10',
    bool trending = false,
  }) {
    return "$_giphyUrl${trending ? 'trending' : 'search'}?"
        "api_key=$_giphyKey"
        "${searchTerm != null ? "&q=$searchTerm" : ""}"
        "&limit=$searchAmount";
  }

  /// Fetch trending GIFs from the Giphy API
  Future<void> _fetchTrendingGifs() async {
    final url = _buildUrl(searchTerm: null, trending: true);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _gifs = data['data'];
      });
    }
  }

  /// Search for GIFs using the Giphy API
  Future<void> _searchGifs(String searchTerm, String searchAmount) async {
    final url = _buildUrl(searchTerm: searchTerm, searchAmount: searchAmount);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _gifs = data['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _searchBarWidget(),
            const SizedBox(height: 12),
            _searchButtonWidget(),
            const SizedBox(height: 12),
            _gifContainerWidget(),
          ],
        ),
      ),
    );
  }

  Widget _searchBarWidget() {
    final List<String> searchAmountList = ['10', '20', '30', '40', '50'];

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            controller: _searchTermController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search Term',
              hintText: 'Search for GIFs',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            value: _searchAmount,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Number of Results',
            ),
            items:
                searchAmountList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                _searchAmount = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _searchButtonWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(onPressed: _resetForm, child: Text('Reset')),
        const SizedBox(width: 24),
        ElevatedButton(onPressed: _submitForm, child: Text('Find some GIFs')),
      ],
    );
  }

  Widget _gifContainerWidget() {
    return _gifs.isEmpty
        ? Center(child: Text('Loading...'))
        : GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _gifs.length,
          itemBuilder: (context, index) {
            final gifUrl = _gifs[index]['images']['fixed_height']['url'];
            return Image.network(gifUrl, fit: BoxFit.cover);
          },
        );
  }
}

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white,
        ),
        child: const Icon(Icons.gif, size: 36, color: Colors.blue),
      ),
      title: const Text('Giphy Finder', style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.blue,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
