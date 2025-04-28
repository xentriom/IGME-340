import 'package:flutter/material.dart';
import 'package:project03/auth/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final AuthProvider auth = AuthProvider();

  @override
  Widget build(BuildContext context) {
    // Get the current theme data
    final ThemeData theme = Theme.of(context);

    // This is a list of items to be displayed in the grid
    // Each item is a map containing an icon, title, and onTap function
    // The onTap function is a placeholder and does nothing
    // Dawg the auto formatting keeps messing it up >:(
    final List<Map<String, dynamic>> items = [
      {
        'icon': Icons.storefront_outlined,
        'title': 'Marketplace',
        'onTap': () {},
      },
      {
        'icon': Icons.workspace_premium_outlined,
        'title': 'Premium',
        'onTap': () {},
      },
      {'icon': Icons.person, 'title': 'Profile', 'onTap': () {}},
      {'icon': Icons.group_outlined, 'title': 'Friends', 'onTap': () {}},
      {'icon': Icons.groups_outlined, 'title': 'Communities', 'onTap': () {}},
      {'icon': Icons.backpack_outlined, 'title': 'Inventory', 'onTap': () {}},
      {'icon': Icons.mail_outline, 'title': 'Messages', 'onTap': () {}},
      {'icon': Icons.developer_mode, 'title': 'Create', 'onTap': () {}},
      {'icon': Icons.article_outlined, 'title': 'Blog', 'onTap': () {}},
      {'icon': Icons.settings_outlined, 'title': 'Settings', 'onTap': () {}},
      {'icon': Icons.info_outline, 'title': 'About', 'onTap': () {}},
      {
        'icon': Icons.security_outlined,
        'title': 'Help & Safety',
        'onTap': () {},
      },
      {'icon': Icons.login_outlined, 'title': 'Quick Login', 'onTap': () {}},
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          spacing: 8.0,
          children: [
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children:
                  items.map((item) {
                    return GestureDetector(
                      onTap: item['onTap'],
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 8.0,
                          children: [
                            Icon(item['icon'], size: 42.0),
                            Text(
                              item['title'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),

            const SizedBox(height: 8.0),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Do nothing bc i dont have time for this
                },
                child: DefaultTextStyle.merge(
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  child: Text("Switch Accounts"),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  auth.logout();
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('username');
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/auth',
                    (route) => false,
                  );
                },
                child: DefaultTextStyle.merge(
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  child: Text("Log Out"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
