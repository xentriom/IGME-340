import 'package:flutter/cupertino.dart';
import 'package:project02/core/shared_pref.dart';
import 'package:project02/core/shared_state.dart';

///
/// FavoriteIcon widget
/// Used to display a favorite icon for a character if logged in
/// allows users to favorite/unfavorite characters
///
/// @param id: character ID
/// @param sharedPref: SharedPref instance
/// @return FavoriteIcon widget
///
/// @author: Jason Chen
/// @version: 1.0.0
/// @since: 2025-03-08
///

class FavoriteIcon extends StatelessWidget {
  final String id;
  final SharedPref sharedPref;

  const FavoriteIcon({required this.id, required this.sharedPref, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: sharedPref.isLoggedIn(),
      builder: (context, loginSnapshot) {
        if (loginSnapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 24,
            height: 24,
            child: CupertinoActivityIndicator(radius: 10),
          );
        }

        final isLoggedIn = loginSnapshot.data ?? false;
        if (!isLoggedIn) {
          return const SizedBox.shrink();
        }

        return ValueListenableBuilder<List<String>>(
          valueListenable: SharedState.favoriteIds,
          builder: (context, favoriteIds, child) {
            final isFavorite = favoriteIds.contains(id);
            return GestureDetector(
              onTap: () async {
                await SharedState.toggleFavorite(id);
              },
              child: Icon(
                isFavorite
                    ? CupertinoIcons.bookmark_fill
                    : CupertinoIcons.bookmark,
                color: CupertinoTheme.of(context).primaryColor,
              ),
            );
          },
        );
      },
    );
  }
}
