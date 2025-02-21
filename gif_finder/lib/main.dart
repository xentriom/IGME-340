import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
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
  // Giphy API URL and Key
  final String _giphyUrl = 'https://api.giphy.com/v1/gifs/';
  final String _giphyKey = '5PuWjWVnwpHUQPZK866vd7wQ2qeCeqg7';

  // Form key and text controller
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchTermController = TextEditingController();

  // State variables
  String _searchTerm = 'Trending';
  String _searchAmount = '10';
  String _searchRating = 'All';
  List<dynamic> _gifs = <dynamic>[];

  // Set initial state
  @override
  void initState() {
    super.initState();
    _fetchGifs(
      searchAmount: _searchAmount,
      searchRating: _searchRating,
      trending: true,
    );
  }

  /// Reset the form and fetch trending GIFs
  void _resetForm() {
    _formKey.currentState!.reset();
    _searchTermController.clear();

    setState(() {
      _searchTerm = 'Trending';
      _searchAmount = '10';
      _searchRating = 'All';
      _gifs.clear();
    });

    _fetchGifs(
      searchAmount: _searchAmount,
      searchRating: _searchRating,
      trending: true,
    );
  }

  /// Submit the form and search for GIFs
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final String searchTerm = _searchTermController.text;

      setState(() {
        _searchTerm = searchTerm;
        _gifs.clear();
      });

      _fetchGifs(
        searchTerm: searchTerm,
        searchAmount: _searchAmount,
        searchRating: _searchRating,
      );
    }
  }

  /// Helper function to build the Giphy API URL
  String _buildUrl({
    required dynamic searchTerm,
    String searchAmount = '10',
    String searchRating = 'All',
    bool trending = false,
  }) {
    return '$_giphyUrl${trending ? 'trending' : 'search'}?'
        'api_key=$_giphyKey'
        '${searchTerm != null ? '&q=$searchTerm' : ''}'
        '&limit=$searchAmount'
        '${searchRating != 'All' ? '&rating=${searchRating.toLowerCase()}' : ''}';
  }

  /// Fetch GIFs from the Giphy API
  Future<void> _fetchGifs({
    String? searchTerm,
    String searchAmount = '10',
    String searchRating = 'All',
    bool trending = false,
  }) async {
    // Build the URL
    final String url = _buildUrl(
      searchTerm: searchTerm,
      searchAmount: searchAmount,
      searchRating: searchRating,
      trending: trending,
    );

    // Fetch the data
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
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
            SizedBox(height: 8),
            _searchButtonWidget(),
            Divider(color: Colors.black, thickness: 1),
            _gifContainerWidget(),
          ],
        ),
      ),
    );
  }

  /// Widget to display the search bar
  Widget _searchBarWidget() {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 12,
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            controller: _searchTermController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search Term',
              hintText: 'Search for GIFs',
            ),
            style: TextStyle(fontFamily: 'Open Sans'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          _searchFilterWidget(),
        ],
      ),
    );
  }

  /// Widget to display the search filter [# of results, rating]
  Widget _searchFilterWidget() {
    // Search amount and rating list
    final List<String> searchAmountList = ['10', '20', '30', '40', '50'];
    final List<String> searchRatingList = ['All', 'G', 'PG', 'PG-13', 'R'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 12,
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
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
        ),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _searchRating,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Rating',
            ),
            items:
                searchRatingList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                _searchRating = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  /// Widget to display the search and reset buttons
  Widget _searchButtonWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 12,
      children: [
        ElevatedButton(
          onPressed: _resetForm,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red[600],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Reset', style: TextStyle(fontFamily: 'Open Sans')),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Find some GIFs',
            style: TextStyle(fontFamily: 'Open Sans'),
          ),
        ),
      ],
    );
  }

  /// Widget to display the GIF container
  Widget _gifContainerWidget() {
    return _gifs.isEmpty
        ? Center(child: Text('Loading...'))
        : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '$_searchTerm GIFs',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: _gifs.length,
              itemBuilder: (context, index) {
                // Gif URL and Media URL
                final String gifUrl = _gifs[index]['url'];
                final dynamic gifMediaUrl =
                    _gifs[index]['images']['fixed_height']['url'];
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          gifMediaUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () async {
                          Uri url = Uri.parse(gifUrl);
                          await launchUrl(url);
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.launch,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
  }
}

/// AppBar Widget, you've seen this on every Flutter app i've submitted
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
      title: const Text(
        'Giphy Finder',
        style: TextStyle(fontFamily: 'Open Sans', color: Colors.white),
      ),
      backgroundColor: Colors.blue,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
