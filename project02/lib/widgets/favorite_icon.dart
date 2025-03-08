import 'package:flutter/cupertino.dart';
import 'package:project02/core/shared_pref.dart';

///
/// FavoriteIcon widget
/// Used to display a favorite icon for a character if logged in
/// allows users to favorite/unfavorite characters
///
/// @param id: character ID
/// @param sharedPref: SharedPref instance
/// @param onFavoriteChanged: callback function when favorite status changes
/// @return FavoriteIcon widget
///
/// @author: Jason Chen
/// @version: 1.0.0
/// @since: 2025-03-08
///

class FavoriteIcon extends StatelessWidget {
  final String id;
  final SharedPref sharedPref;
  final VoidCallback onFavoriteChanged;

  const FavoriteIcon({
    required this.id,
    required this.sharedPref,
    required this.onFavoriteChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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

        return FutureBuilder(
          future: sharedPref.isFavorite(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                width: 24,
                height: 24,
                child: CupertinoActivityIndicator(radius: 10),
              );
            }

            final isFavorite = snapshot.data ?? false;
            return GestureDetector(
              onTap: () async {
                await sharedPref.setFavorite(id);
                onFavoriteChanged();
              },
              child: Icon(
                isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                color: CupertinoColors.systemRed,
              ),
            );
          },
        );
      },
    );
  }
}
