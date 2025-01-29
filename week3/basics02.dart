import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IGME-340 Basic App"),
      ),
      body: Center(
        child: Container(
          // margin on right
          margin: EdgeInsets.only(right: 40),
          child: Column(
            // align items to the end
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 400,
                height: 100,
                color: Colors.yellow,
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Item 01"),
                ),
              ),
              Container(
                width: 300,
                height: 100,
                color: Colors.red,
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Item 02"),
                ),
              ),
              Container(
                width: 200,
                height: 100,
                color: Colors.blue,
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Item 03"),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.green,
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Item 04"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
