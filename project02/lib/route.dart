import 'package:flutter/cupertino.dart';
import 'package:project02/screens/explore_screen.dart';
import 'package:project02/screens/favorites_screen.dart';
import 'package:project02/screens/settings_screen.dart';

///
/// Route Generator to generate routes for the app
///
/// @author: Jason Chen
/// @version: 1.0.0
/// @since: 2025-03-07
///

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/explore':
        return CupertinoPageRoute(builder: (_) => ExploreScreen());
      case '/favorites':
        return CupertinoPageRoute(builder: (_) => FavoritesScreen());
      case '/settings':
        return CupertinoPageRoute(builder: (_) => SettingsScreen());
      default:
        return CupertinoPageRoute(builder: (_) => ExploreScreen());
    }
  }
}
