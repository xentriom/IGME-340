import 'package:flutter/cupertino.dart';
import 'package:project02/core/shared_pref.dart';
import 'package:project02/core/shared_state.dart';
import 'package:project02/core/yatta.dart';
import 'package:project02/widgets/view_toggle.dart';
import 'package:project02/widgets/grid_builder.dart';
import 'package:project02/widgets/list_builder.dart';

///
/// Favorites Screen
/// Displays user's favorite characters
/// Filter by search query
/// Toggle between list and grid view
///
/// @author: Jason Chen
/// @version: 1.0.1
/// @since: 2025-03-09
///

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // Initialize shared preferences and Yatta API
  final SharedPref sharedPref = SharedPref();
  final Yatta yatta = Yatta();

  // Initialize character variables
  List<dynamic> allCharacters = [];
  List<dynamic> filteredFavoriteCharacters = [];
  bool isLoading = false;

  // Initialize view variables
  String searchQuery = '';
  bool isListView = true;

  @override
  void initState() {
    super.initState();
    _fetchCharactersAndFavorites();
  }

  Future<void> _fetchCharactersAndFavorites() async {
    try {
      setState(() => isLoading = true);
      final username = await sharedPref.getUsername();
      final characters = await yatta.getCharacters();
      final favs = await sharedPref.getFavorites();

      setState(() {
        SharedState.currentUser.value = username;
        SharedState.favoriteIds.value = favs;
        allCharacters = characters;
        _filterFavorites();
        isLoading = false;
      });
    } catch (error) {
      setState(() => isLoading = false);
    }
  }

  void _filterFavorites() {
    filteredFavoriteCharacters =
        allCharacters
            .where(
              (character) => SharedState.favoriteIds.value.contains(
                character['id'].toString(),
              ),
            )
            .where(
              (character) =>
                  searchQuery.isEmpty ||
                  character['name'].toString().toLowerCase().contains(
                    searchQuery.toLowerCase(),
                  ),
            )
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          SharedState.currentUser.value != null &&
                  SharedState.favoriteIds.value.isNotEmpty
              ? 'Interastral Guide'
              : '',
        ),
        backgroundColor: CupertinoColors.secondarySystemBackground,
        border: null,
      ),
      child: SafeArea(child: _buildContent()),
    );
  }

  Widget _buildContent() {
    return ValueListenableBuilder<String?>(
      valueListenable: SharedState.currentUser,
      builder: (context, user, child) {
        if (user == null) {
          return _buildMessage(
            assetUrl: 'assets/images/AglaeaCross.jpeg',
            message: 'Log in to view your bookmarks.',
          );
        }

        return ValueListenableBuilder<List<String>>(
          valueListenable: SharedState.favoriteIds,
          builder: (context, favoriteIds, child) {
            if (isLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }

            if (favoriteIds.isEmpty) {
              return _buildMessage(
                assetUrl: 'assets/images/ThertaHat.jpeg',
                message: 'No bookmarks found~',
              );
            }

            _filterFavorites();
            return _buildFavoritesList();
          },
        );
      },
    );
  }

  /// Helper to display message with image
  Widget _buildMessage({required String assetUrl, required String message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(assetUrl, width: 200, height: 200, fit: BoxFit.contain),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: CupertinoColors.darkBackgroundGray,
            ),
          ),
        ],
      ),
    );
  }

  /// Helper to build favorites list
  Widget _buildFavoritesList() {
    return Container(
      color: CupertinoColors.systemGroupedBackground,
      child: Column(
        spacing: 8,
        children: [
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: CupertinoSearchTextField(
                    placeholder: 'Search',
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        _filterFavorites();
                      });
                    },
                  ),
                ),
                ToggleViewButtons(
                  isListView: isListView,
                  onToggle: (value) {
                    setState(() => isListView = value);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child:
                  isListView
                      ? BuildListView(
                        filteredCharacters: filteredFavoriteCharacters,
                        isLoading: isLoading,
                      )
                      : BuildGridView(
                        filteredCharacters: filteredFavoriteCharacters,
                        isLoading: isLoading,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
