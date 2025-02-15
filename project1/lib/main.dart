import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/valley.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello World',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// AppBarWidget
// Used to create the AppBar for the Tree & Wood app.
// Builds two icons and a title.
// Leading icon is a pickaxe, and the trailing icon is a people icon.
// The title is 'Trees & Wood'.
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

    void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[300],
              shape: RoundedRectangleBorder(),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(
                fontFamily: 'VT323',
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          )
        ],
        title: const Text(
          'About',
          style: TextStyle(fontFamily: 'VT323', fontSize: 19.0),
        ),
        contentPadding: const EdgeInsets.all(20.0),
        content: const Text(
          'Created by Jason Chen\nIGME 340 Design to spec project\nFebruary 13, 2025',
          style: TextStyle(fontFamily: 'VT323', fontSize: 19.0),
        ),
        shape: RoundedRectangleBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Trees & Wood',
        style: TextStyle(
          fontFamily: 'Retro',
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.grey,
      leading: Padding(
        padding: const EdgeInsets.all(12),
        child: SvgPicture.asset(
          'assets/images/pickaxe.svg',
          colorFilter: ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            'assets/images/people.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () {
            _showAboutDialog(context);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
