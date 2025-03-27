import 'package:flutter/cupertino.dart';
import 'package:project02/core/constants.dart';
import 'package:project02/core/shared_pref.dart';
import 'package:project02/core/shared_state.dart';
import 'package:project02/core/yatta.dart';
import 'package:project02/widgets/grid_builder.dart';
import 'package:project02/widgets/list_builder.dart';
import 'package:project02/widgets/view_toggle.dart';

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
        filteredCharacters = data;
        isLoading = false;
      });

      _filterCharacters();
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  void _filterCharacters() {
    setState(() {
      filteredCharacters =
          characters.where((character) {
            final name = character['name'].toString().toLowerCase();
            final matchesSearch =
                searchQuery.isEmpty || name.contains(searchQuery.toLowerCase());

            final type = character['types']['combatType'] as String;
            final convertedType = constants.typesMap[type];
            final matchesType =
                selectedType == 'Elements' || convertedType == selectedType;

            final path = character['types']['pathType'] as String;
            final convertedPath = constants.pathsMap[path];
            final matchesPath =
                selectedPath == 'Paths' || convertedPath == selectedPath;

            return matchesSearch && matchesType && matchesPath;
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // listens for changes in currentUser (to show/hide favorite icon)
    return ValueListenableBuilder(
      valueListenable: SharedState.currentUser,
      builder: (context, user, child) {
        return CupertinoPageScaffold(
          child: SafeArea(
            child: Container(
              color: CupertinoColors.systemGroupedBackground,
              child: Column(
                spacing: 2,
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      spacing: 8,
                      children: [
                        Expanded(
                          child: _buildDropdownButton(
                            context,
                            selectedType!,
                            constants.types,
                            (value) {
                              setState(() {
                                selectedType = value;
                                _filterCharacters();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: _buildDropdownButton(
                            context,
                            selectedPath!,
                            constants.paths,
                            (value) {
                              setState(() {
                                selectedPath = value;
                                _filterCharacters();
                              });
                            },
                          ),
                        ),
                        ToggleViewButtons(
                          isListView: isListView,
                          onToggle:
                              (value) => setState(() => isListView = value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child:
                          isListView
                              ? BuildListView(
                                filteredCharacters: filteredCharacters,
                                isLoading: isLoading,
                              )
                              : BuildGridView(
                                filteredCharacters: filteredCharacters,
                                isLoading: isLoading,
                              ),
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
}
