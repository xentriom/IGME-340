import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project02/route.dart';
import 'package:project02/core/shared_pref.dart';
import 'package:project02/core/shared_state.dart';
import 'package:project02/screens/explore_screen.dart';
import 'package:project02/screens/favorites_screen.dart';
import 'package:project02/screens/settings_screen.dart';

///
/// Main App
/// https://github.com/xentriom/IGME-340/tree/main/project02
///
/// @author: Jason Chen
/// @version: 1.0.0
/// @since: 2025-03-07
///

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedState.loadInitialState();
  await _initializeDummyUsers();

  runApp(const MainApp());
}

/// Initialize dummy users (lore accurate)
Future<void> _initializeDummyUsers() async {
  final SharedPref sharedPref = SharedPref();
  final List<Map<String, dynamic>> dummyUsers = [
    {
      'username': 'xentriom',
      'password': 'hello123',
      'favorites': ['1006', '1307', '1402'],
      'theme': ThemeMode.dark,
    },
    {
      'username': 'galactic baseballer',
      'password': 'password',
      'favorites': ['1001', '1002', '1003', '1004'],
      'theme': ThemeMode.system,
    },
    {
      'username': 'phainon',
      'password': 'mydei',
      'favorites': ['1404'],
      'theme': ThemeMode.light,
    },
  ];

  for (var user in dummyUsers) {
    await sharedPref.register(
      user['username'] as String,
      user['password'] as String,
      favorites: user['favorites'] as List<String>?,
      theme: user['theme'] as ThemeMode?,
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: SharedState.theme,
      builder: (context, theme, child) {
        return CupertinoApp(
          debugShowCheckedModeBanner: false,
          theme: CupertinoThemeData(
            brightness:
                theme == ThemeMode.system
                    ? MediaQuery.of(context).platformBrightness
                    : theme == ThemeMode.dark
                    ? Brightness.dark
                    : Brightness.light,
            primaryColor: CupertinoColors.activeBlue,
            scaffoldBackgroundColor: CupertinoColors.systemBackground,
            barBackgroundColor: CupertinoColors.systemGrey6,
            textTheme: CupertinoTextThemeData(
              textStyle: TextStyle(color: CupertinoColors.label),
            ),
          ),
          onGenerateRoute: RouteGenerator.generateRoute,
          home: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.compass),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.bookmark),
                  label: 'Bookmarks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings),
                  label: 'Settings',
                ),
              ],
            ),
            tabBuilder: (context, index) {
              switch (index) {
                case 0:
                  return CupertinoTabView(
                    builder:
                        (context) =>
                            const CupertinoPageScaffold(child: ExploreScreen()),
                  );
                case 1:
                  return CupertinoTabView(
                    builder:
                        (context) => const CupertinoPageScaffold(
                          child: FavoritesScreen(),
                        ),
                  );
                default:
                  return CupertinoTabView(
                    builder:
                        (context) => const CupertinoPageScaffold(
                          child: SettingsScreen(),
                        ),
                  );
              }
            },
          ),
        );
      },
    );
  }
}
