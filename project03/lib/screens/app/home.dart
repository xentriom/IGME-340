import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project03/auth/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);

    return Center(child: Text('Hello, ${auth.username}'));
  }
}
