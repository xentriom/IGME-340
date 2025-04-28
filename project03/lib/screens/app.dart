import 'package:flutter/material.dart';
import 'package:project03/screens/app/home.dart';
import 'package:project03/screens/app/charts.dart';
import 'package:project03/screens/app/avatar.dart';
import 'package:project03/screens/app/party.dart';
import 'package:project03/screens/app/more.dart';

///
/// Main App Screen
/// This screen is the main screen of the app.
/// It contains the bottom navigation bar and the app bar.
/// It is the main screen that the user will see after logging in.
/// Screens are located in the app folder.
/// 
/// @author: Jason
/// @version: 1.0
/// @since 04/22/2025
/// 

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(context, currentPageIndex),
      body:
          [
            const HomeScreen(),
            const ChartScreen(),
            const AvatarScreen(),
            const PartyScreen(),
            const MoreScreen(),
          ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: theme.colorScheme.inversePrimary,
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bar_chart),
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Charts',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.circle_rounded),
            icon: Icon(Icons.circle_outlined),
            label: 'Avatar',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.people),
            icon: Icon(Icons.people_outline),
            label: 'Party',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.more_horiz),
            icon: Icon(Icons.more_horiz_outlined),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

/// Function to build the AppBar based on the current page index
PreferredSizeWidget _buildAppBar(context, currentPageIndex) {
  switch (currentPageIndex) {
    case 0:
      return AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.commit), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/app/notification');
            },
          ),
        ],
      );
    case 1:
      return AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Charts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.commit), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/app/notification');
            },
          ),
        ],
      );
    case 2:
      return AppBar(
        leading: const BackButton(),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      );
    case 3:
      return AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Party",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/app/notification');
            },
          ),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
        ],
      );
    case 4:
      return AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "More",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.commit), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/app/notification');
            },
          ),
        ],
      );
    default:
      return AppBar();
  }
}
