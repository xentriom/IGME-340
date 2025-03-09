import 'package:flutter/cupertino.dart';
import 'package:project02/core/shared_pref.dart';
import 'package:project02/core/shared_state.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final SharedPref sharedPref = SharedPref();
  String? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    final username = await sharedPref.getUsername();
    setState(() {
      user = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: SafeArea(child: _buildContent()));
  }

  Widget _buildContent() {
    return ValueListenableBuilder<String?>(
      // Listen to changes in currentUser
      valueListenable: SharedState.currentUser,
      builder: (context, user, child) {
        // Not logged in, display a message
        if (user == null) {
          return _buildMessage(
            assetUrl: 'assets/images/AglaeaCross.jpeg',
            message: 'Log in to view your bookmarks.',
          );
        }

        return ValueListenableBuilder<List<String>>(
          // Listen to changes in favoriteIds
          valueListenable: SharedState.favoriteIds,
          builder: (context, favorites, child) {
            // No favorites, display a message
            if (favorites.isEmpty) {
              return _buildMessage(
                assetUrl: 'assets/images/ThertaHat.jpeg',
                message: 'No bookmarks found.',
              );
            }

            // Display the list of favorites
            return _buildFavoritesList(favorites);
          },
        );
      },
    );
  }

  /// Helper method to build a message with an image
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

  /// Helper method to build the list of favorites
  Widget _buildFavoritesList(List<String> favorites) {
    return Column(
      children: [Text('${favorites.length.toString()} characters saved.')],
    );
  }
}
