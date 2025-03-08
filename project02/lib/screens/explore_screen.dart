import 'package:flutter/cupertino.dart';
import 'package:project02/core/yatta.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final Yatta yatta = Yatta();
  List<dynamic> characters = [];
  bool isLoading = false;

  String? selectedType = 'All';
  String? selectedPath = 'All';
  bool isListView = true;

  final List<String> types = ['All', 'Fire', 'Water', 'Earth', 'Air'];
  final List<String> paths = ['All', 'Sword', 'Bow', 'Staff', 'Axe'];

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
  }

  Future<void> _fetchCharacters() async {
    try {
      setState(() => isLoading = true);
      final data = await yatta.getCharacters();
      print(data);
      setState(() {
        characters = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      // Handle error (e.g., show dialog)
      print('Failed to fetch characters: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Explore')),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: CupertinoSearchTextField(
                placeholder: 'Search...',
                onChanged: (value) {
                  print('Search query: $value');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildDropdownButton(context, selectedType!, types, (
                      value,
                    ) {
                      setState(() => selectedType = value);
                    }),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildDropdownButton(context, selectedPath!, paths, (
                      value,
                    ) {
                      setState(() => selectedPath = value);
                    }),
                  ),
                  const SizedBox(width: 8),
                  _buildToggleButtons(),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: SingleChildScrollView(
                  child: isListView ? _buildListView() : _buildGridView(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method to build dropdown button
  Widget _buildDropdownButton(
    BuildContext context,
    String selected,
    List<String> options,
    Function(String) onSelected,
  ) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: CupertinoColors.systemGrey5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(selected, style: const TextStyle(color: CupertinoColors.black)),
          const Icon(CupertinoIcons.chevron_down, size: 16),
        ],
      ),
      onPressed: () => _showPicker(context, options, onSelected),
    );
  }

  /// Toggle buttons for list and grid view
  Widget _buildToggleButtons() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() => isListView = true),
          child: Icon(
            CupertinoIcons.list_bullet,
            color:
                isListView
                    ? CupertinoTheme.of(context).primaryColor
                    : CupertinoColors.systemGrey,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => setState(() => isListView = false),
          child: Icon(
            CupertinoIcons.square_grid_2x2,
            color:
                !isListView
                    ? CupertinoTheme.of(context).primaryColor
                    : CupertinoColors.systemGrey,
          ),
        ),
      ],
    );
  }

  /// Helper method to show picker
  void _showPicker(
    BuildContext context,
    List<String> options,
    Function(String) onSelected,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder:
          (context) => CupertinoActionSheet(
            actions: [
              SizedBox(
                height: 200,
                child: CupertinoPicker(
                  itemExtent: 32.0,
                  onSelectedItemChanged: (index) {
                    onSelected(options[index]);
                  },
                  children: options.map((option) => Text(option)).toList(),
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: const Text('Done'),
              onPressed: () => Navigator.pop(context),
            ),
          ),
    );
  }

  /// List view, 20 placeholder items
  Widget _buildListView() {
    if (isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    if (characters.isEmpty) {
      return const Center(child: Text('No characters found.'));
    }

    return Column(
      children:
          characters.map((character) {
            final id = character['id'].toString();
            final name = character['name'];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: () async {
                    final detail = await yatta.getCharacterDetail(id);
                    print('Character detail: $detail');
                  },
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(name),
                ),
              ),
            );
          }).toList(),
    );
  }

  /// Grid view, 20 placeholder items
  Widget _buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemCount: 20,
      itemBuilder:
          (context, index) => CupertinoButton.filled(
            onPressed: () {},
            child: Text('Item $index'),
          ),
    );
  }
}
