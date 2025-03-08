import 'package:flutter/cupertino.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Explore Screen'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const Text('Explore')],
          ),
        ),
      ),
    );
  }
}
