import 'package:flutter/cupertino.dart';
import 'package:project02/route.dart';
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

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(primaryColor: CupertinoColors.activeBlue),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
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
                builder: (context) {
                  return CupertinoPageScaffold(child: ExploreScreen());
                },
              );
            case 1:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: FavoritesScreen());
                },
              );
            default:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: SettingsScreen());
                },
              );
          }
        },
      ),
    );
  }
}
