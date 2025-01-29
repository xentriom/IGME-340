import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: 'Courier',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[300],
        textTheme: TextTheme(
          displayLarge: TextStyle(
              color: Colors.black, fontSize: 48, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(
              color: Colors.black87, fontSize: 36, fontWeight: FontWeight.w600),
          displaySmall: TextStyle(
              color: Colors.black54, fontSize: 24, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.normal),
          bodySmall: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.normal),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
          textStyle: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        )),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Courier',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.blueGrey[500],
        textTheme: TextTheme(
          displayLarge: TextStyle(
              color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(
              color: Colors.white70, fontSize: 36, fontWeight: FontWeight.w600),
          displaySmall: TextStyle(
              color: Colors.white60, fontSize: 24, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.normal),
          bodySmall: TextStyle(
              color: Colors.white60,
              fontSize: 14,
              fontWeight: FontWeight.normal),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.grey,
          textStyle: TextStyle(
              color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
        )),
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("IGME-340: Themes"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TextButton
            TextButton(
              onPressed: () {
                print("Text Button");
              },
              style: TextButton.styleFrom(
                backgroundColor: theme.colorScheme.primaryContainer,
                foregroundColor: theme.colorScheme.onPrimaryContainer,
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: Text("Text Button"),
            ),
            // OutlinedButton
            OutlinedButton(
              onPressed: () {
                print("Outlined Button");
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: theme.colorScheme.secondaryContainer,
                foregroundColor: theme.colorScheme.onSecondaryContainer,
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: Text("Outlined Button"),
            ),
            // ElevatedButton with Icon
            ElevatedButton.icon(
              onPressed: () {
                print("Elevated Button with Icon");
              },
              icon: Icon(Icons.star, size: 20),
              label: Text("Icon Button"),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.tertiary,
                foregroundColor: theme.colorScheme.onTertiary,
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side:
                      BorderSide(color: theme.colorScheme.onTertiary, width: 2),
                ),
              ),
            ),
            Container(
              width: 300,
              height: 200,
              color: theme.colorScheme.primary,
              child: Text("I am Green", style: theme.textTheme.displayLarge),
            ),
            Container(
              width: 200,
              height: 200,
              color: theme.colorScheme.secondary,
              child: Text("I am Yellow", style: theme.textTheme.displayMedium),
            ),
            Container(
              width: 350,
              height: 100,
              color: theme.colorScheme.error,
              child: Text("I am Pink", style: theme.textTheme.displaySmall),
            ),
            ElevatedButton(
              key: Key("elevatedButton1"),
              onPressed: () {
                print("shocking");
              },
              child: Text('Elevated Button'),
            ),
            ElevatedButton(
              key: Key("elevatedButton2"),
              onPressed: () {
                print("oh dear");
              },
              child: Text('Elevated Button', style: TextStyle(fontSize: 24)),
            )
          ],
        ),
      ),
    );
  }
}
