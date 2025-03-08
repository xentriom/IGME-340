import 'package:flutter/cupertino.dart';

class CharacterScreen extends StatelessWidget {
  const CharacterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(previousPageTitle: 'Back'),
        middle: Text('Character Name'),
        trailing: Icon(CupertinoIcons.heart),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const Text('Character')],
          ),
        ),
      ),
    );
  }
}
