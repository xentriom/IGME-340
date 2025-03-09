import 'package:flutter/cupertino.dart';
import 'package:project02/core/constants.dart';
import 'package:project02/core/yatta.dart';
import 'package:project02/core/shared_pref.dart';
import 'package:project02/widgets/favorite_icon.dart';

///
/// Explore Screen
/// Displays Honkai: Star Rail characters
/// Filter by search query, type, and path
/// Toggle between list and grid view
///
/// @author: Jason Chen
/// @version: 1.0.0
/// @since: 2025-03-08
///

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final Constants constants = Constants();
  final Yatta yatta = Yatta();
  final SharedPref sharedPref = SharedPref();

  List<dynamic> characters = [];
  List<dynamic> filteredCharacters = [];
  bool isLoading = false;

  String searchQuery = '';
  String? selectedType = 'Elements';
  String? selectedPath = 'Paths';
  bool isListView = true;

  final List<String> types = [
    'Elements',
    'Physical',
    'Fire',
    'Ice',
    'Lightning',
    'Wind',
    'Quantum',
    'Imaginary',
  ];
  final List<String> paths = [
    'Paths',
    'Destruction',
    'The Hunt',
    'Erudition',
    'Harmony',
    'Nihility',
    'Preservation',
    'Abundance',
    'Rememberance',
  ];

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
  }

  Future<void> _fetchCharacters() async {
    try {
      setState(() => isLoading = true);
      final data = await yatta.getCharacters();

      setState(() {
        characters = data;
        _filterCharacters();
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  void _filterCharacters() {
    setState(() {
      filteredCharacters =
          characters.where((character) {
            // Filter by search query
            final name = character['name'].toString().toLowerCase();
            final matchesSearch =
                searchQuery.isEmpty || name.contains(searchQuery.toLowerCase());

            // Filter by type
            final type = character['types']['combatType'];
            final convertedType = constants.types[type];
            final matchesType =
                selectedType == 'Elements' || convertedType == selectedType;

            // Filter by path
            final path = character['types']['pathType'];
            final convertedPath = constants.paths[path];
            final matchesPath =
                selectedPath == 'Paths' || convertedPath == selectedPath;

            return matchesSearch && matchesType && matchesPath;
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Interastral Guide'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: CupertinoSearchTextField(
                placeholder: 'Search...',
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    _filterCharacters();
                  });
                },
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildDropdownButton(context, selectedType!, types, (
                      value,
                    ) {
                      setState(() {
                        selectedType = value;
                        _filterCharacters();
                      });
                    }),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildDropdownButton(context, selectedPath!, paths, (
                      value,
                    ) {
                      setState(() {
                        selectedPath = value;
                        _filterCharacters();
                      });
                    }),
                  ),
                  const SizedBox(width: 8),
                  _buildToggleButtons(),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: isListView ? _buildListView() : _buildGridView(),
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
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                  itemExtent: 32,
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

  /// List view
  Widget _buildListView() {
    if (isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    if (filteredCharacters.isEmpty) {
      return const Center(child: Text('No characters found.'));
    }

    return ListView.builder(
      itemCount: filteredCharacters.length,
      itemBuilder: (context, index) {
        final character = filteredCharacters[index];
        final id = character['id'].toString();
        final name = character['name'];
        final rarity = character['rank'];
        final path = character['types']['pathType'];
        final type = character['types']['combatType'];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/character/$id');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Stack(
              children: [
                Container(
                  height: 96,
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey6,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          yatta.getAvatarIconUrl(id),
                          width: 96,
                          height: 96,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: List.generate(
                                rarity,
                                (index) => Icon(
                                  CupertinoIcons.star_fill,
                                  color:
                                      rarity == 4
                                          ? CupertinoColors.systemPurple
                                          : CupertinoColors.systemYellow,
                                  size: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                _buildBadge('path', path),
                                const SizedBox(width: 8),
                                _buildBadge('type', type),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: FavoriteIcon(
                    id: id,
                    sharedPref: sharedPref,
                    onFavoriteChanged: () => setState(() {}),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Helper method to build badge
  Widget _buildBadge(String type, String data) {
    final label =
        type == 'path'
            ? constants.paths[data] ?? data
            : constants.types[data] ?? data;
    final iconLabel =
        type == 'path' ? constants.pathsIcon[data] : constants.typesIcon[data];
    final iconUrl =
        type == 'path'
            ? yatta.getPathIcon(iconLabel ?? '')
            : yatta.getTypeIcon(iconLabel ?? '');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey5,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.network(iconUrl, width: 16, height: 16),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  /// Grid view, 20 placeholder items
  Widget _buildGridView() {
    if (isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    if (filteredCharacters.isEmpty) {
      return const Center(child: Text('No characters found.'));
    }

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 0,
        childAspectRatio: 1,
      ),
      itemCount: filteredCharacters.length,
      itemBuilder: (context, index) {
        final character = filteredCharacters[index];
        final id = character['id'].toString();
        final name = character['name'];
        final rarity = character['rank'];
        final path = character['types']['pathType'];
        final type = character['types']['combatType'];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/character/$id');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(yatta.getAvatarIconUrl(id)),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 72,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            CupertinoColors.white.withValues(alpha: 0),
                            rarity == 4
                                ? CupertinoColors.systemPurple.withOpacity(0.8)
                                : CupertinoColors.systemYellow.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Center(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.darkBackgroundGray,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            yatta.getTypeIcon(constants.typesIcon[type] ?? ''),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Image(
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            yatta.getPathIcon(constants.pathsIcon[path] ?? ''),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: FavoriteIcon(
                      id: id,
                      sharedPref: sharedPref,
                      onFavoriteChanged: () => setState(() {}),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
