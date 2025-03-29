import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// About screen
/// This screen is used to display the about page of the app.
/// It contains a webview that loads the about page of the app.
/// For the source code, it is located in assets/web/
///
/// author: Jason Chen
/// version: 1.0.0
/// since: 2025-03-29
///

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse("https://jc5892-340-p2.vercel.app"));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text(' ')),
      child: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
