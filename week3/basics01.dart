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
      // Wrap Container in Align and center it
      body: Align(
        // align to the top left
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              // 4 Containers with text cenetered
              Container(
                width: 150,
                height: 150,
                color: Colors.yellow,
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Item 01"),
                ),
              ),
              Container(
                width: 150,
                height: 150,
                color: Colors.red,
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Item 02"),
                ),
              ),
              Container(
                width: 150,
                height: 150,
                color: Colors.blue,
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Item 03"),
                ),
              ),
              Container(
                width: 150,
                height: 150,
                color: Colors.green,
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Item 04"),
                ),
              ),
            ],
          )),
    );
  }
}
