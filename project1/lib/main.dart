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
          BackgroundImageWidget(),
          ScollableViewWidget(),
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

  // Displays an about dialog when the people icon is pressed
  // The dialog contains basic information with an Ok button
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'About',
          style: TextStyle(fontFamily: 'VT323', fontSize: 20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Created by Jason Chen',
              style: TextStyle(
                fontFamily: 'VT323',
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Based on the work done in 235\'s Design to Spec Homework.',
              style: TextStyle(
                fontFamily: 'VT323',
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'February 13, 2025',
              style: TextStyle(
                fontFamily: 'VT323',
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[500],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: TextStyle(
                fontFamily: 'VT323',
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          )
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: Colors.grey[300],
      ),
    );
  }

  // Builds the AppBar with a title and two icons
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
        padding: EdgeInsets.all(12),
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
          onPressed: () => _showAboutDialog(context),
        ),
      ],
    );
  }

  // Returns the preferred size of the AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// BackgroundImageWidget
// Used to create a background image for the app.
class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/valley.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// ScollableViewWidget
// Used to create a scrollable view for the app.
class ScollableViewWidget extends StatelessWidget {
  const ScollableViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate half the height of the screen
    double halfHeight = MediaQuery.of(context).size.height / 2;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OakTreeWidget(),
          TreeInfoWidget(),
          SizedBox(height: halfHeight),
          OakCraftablesWidget(),
          Divider(
            color: Colors.white,
            thickness: 12,
          ),
          FooterWidget(),
        ],
      ),
    );
  }
}

// OakTreeWidget
// Used to create an oak tree widget.
// The widget is a square container with a gradient background.
class OakTreeWidget extends StatelessWidget {
  const OakTreeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth;

        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFA7C1BE).withValues(alpha: .95),
                Color(0xFF334644),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.white,
              width: 8,
            ),
          ),
          padding: EdgeInsets.all(24),
          child: Image.asset(
            'assets/images/oaktree.png',
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}

// TreeInfoWidget
// Used to create a widget with information about the oak tree.
// The widget is a container with a column of text widgets.
class TreeInfoWidget extends StatelessWidget {
  const TreeInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[700],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The Oak Tree',
            style: TextStyle(
              fontFamily: 'Retro',
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut porta metus risus, tempus pulvinar est finibus nec.',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Phasellus tempus gravida condimentum. Nullam scelerisque tristique pretium. Sed quis feugiat arcu, vel sodales ante. Fusce convallis sapien non ex rutrum volutpat sit amet et arcu. In lectus leo, aliquam vel maximus commodo, maximus id leo.',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Aenean non faucibus metus, venenatis dictum lacus. Nulla tempor eget ante vitae blandit. In hac habitasse platea dictumst. Done tortor sem, vulputate in iaculis eu, rutrum eget leo. Nunc et laoreet diam. Praesent diam eros, volutpat eu hendrerit quis, scelerisque placerat enim.',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// OakCraftablesWidget
// Used to create a widget with information about oak craftables.
// The widget is a container with a column of wood craftable cards.
class OakCraftablesWidget extends StatelessWidget {
  const OakCraftablesWidget({super.key});

  void _showDetailDialog(BuildContext context, String title, String imagePath,
      String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'VT323',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        content: Container(
          color: Colors.grey[100],
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                color: Color(0xFF334F4D),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(height: 8),
              SingleChildScrollView(
                child: Text(
                  'Planks are common blocks used as building blocks and in crafting recipes. They are one of the first things that a player can craft in',
                  style: TextStyle(
                    fontFamily: 'VT323',
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[500],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Close',
              style: TextStyle(
                fontFamily: 'VT323',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.grey[600],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      color: Colors.grey[800],
      child: Column(
        children: [
          buildItemCard(context, 'Planks', 'assets/images/planks.png',
              'Planks are common blocks used as building blocks and in crafting recipes. They are one of the first things that a player can craft in'),
          SizedBox(height: 16),
          buildItemCard(context, 'Sticks', 'assets/images/stick.png',
              'A stick is an item used for crfting many tools and items.'),
          SizedBox(height: 16),
          buildItemCard(context, 'Chests', 'assets/images/chest.png',
              'Pellentesque molestie nisl libero, a tincidunt arcu auctor in. Integer sed massa neo enim dictum tempor et sit amet nisl. Sed'),
          SizedBox(height: 16),
          buildItemCard(context, 'Stairs', 'assets/images/stairs.png',
              'Sed sodales vel nulla nec sollicitudin. Vestibulum sodales conque gravida, Nam nulla massa, rhoncus pulvinar in, sagittis id'),
        ],
      ),
    );
  }

  Widget buildItemCard(BuildContext context, String title, String imagePath,
      String description) {
    return GestureDetector(
      child: Container(
        color: Colors.grey[700],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Color(0xFF2E4E45),
                border: Border.all(
                  color: Colors.white,
                  width: 6,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontFamily: 'Retro', fontSize: 12, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                    imagePath,
                    width: 90,
                    height: 90,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  description,
                  style: TextStyle(
                      fontFamily: 'VT323', fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () => _showDetailDialog(context, title, imagePath, description),
    );
  }
}

// FooterWidget
// Used to create a footer widget for the app.
// The widget is a stack with an image and text.
class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image(
          image: AssetImage('assets/images/trees.jpg'),
          height: 350,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 8,
          child: Text(
            'Trees are pretty cool\nright?',
            style: TextStyle(
              fontFamily: 'retro',
              fontSize: 18,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          bottom: 10.0,
          child: Text(
            'Copyright 2022\nRIT School of Interactive Games\nand Media',
            style: TextStyle(
              fontFamily: 'retro',
              fontSize: 14,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
