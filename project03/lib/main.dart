import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:project03/auth/auth_provider.dart';

import 'package:project03/screens/custom_splash.dart';
import 'package:project03/screens/auth.dart';
import 'package:project03/screens/login.dart';
import 'package:project03/screens/register.dart';
import 'package:project03/screens/app.dart';
import 'package:project03/screens/app/notification.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GCP',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark(useMaterial3: true).textTheme,
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/auth': (_) => const AuthScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/app': (_) => const AppScreen(),
        '/app/notification': (_) => const NotificationScreen(),
      },
    );
  }
}
