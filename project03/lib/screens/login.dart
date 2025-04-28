import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project03/auth/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _error;

  Future<void> _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty) {
      setState(() => _error = 'Please enter a username.');
      return;
    }

    if (password.isEmpty) {
      setState(() => _error = 'Please enter a password.');
      return;
    }

    // Check firebase for username and password
    // If passwords match continue

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);

    Provider.of<AuthProvider>(context, listen: false).login(username);
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Image.asset('assets/images/logo.png', height: 128),
            const SizedBox(height: 64),
            Container(
              child: Column(
                spacing: 18,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _handleLogin();
                      },
                      child: DefaultTextStyle.merge(
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        child: Text("Login"),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // Do nothing bc i dont have time for this
                      },
                      child: DefaultTextStyle.merge(
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        child: Text("Email Me a One-Time Code"),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/app');
                      },
                      child: DefaultTextStyle.merge(
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        child: Text("Quick Login"),
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      // Do nothing bc i dont have time for this
                    },
                    child: DefaultTextStyle.merge(
                      style: const TextStyle(fontSize: 12),
                      child: Text("Forgot Password or Username?"),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 12,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Do nothing bc i dont have time for this
                        },
                        child: DefaultTextStyle.merge(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                          ),
                          child: Text("Terms"),
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          // Do nothing bc i dont have time for this
                        },
                        child: DefaultTextStyle.merge(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                          ),
                          child: Text("Privacy"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (_error != null) ...[
              const SizedBox(height: 16),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }
}
