import 'package:flutter/cupertino.dart';
import 'package:project02/core/shared_pref.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SharedPref _sharedPred = SharedPref();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _username;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Check if the user is logged in
  Future<void> _checkLoginStatus() async {
    setState(() => _isLoading = true);
    final bool loggedIn = await _sharedPred.isLoggedIn();
    final String? username = await _sharedPred.getUsername();

    setState(() {
      _isLoggedIn = loggedIn;
      _username = username;
      _isLoading = false;
    });
  }

  /// Handle login
  Future<void> _handleLogin() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showError("Please enter both username and password.");
      return;
    }

    setState(() => _isLoading = true);
    final String? error = await _sharedPred.login(username, password);
    setState(() => _isLoading = false);

    if (error == null) {
      _usernameController.clear();
      _passwordController.clear();
      await _checkLoginStatus();
    } else {
      _showError(error);
    }
  }

  /// Handle registration
  Future<void> _handleRegister() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showError("Please enter both username and password.");
      return;
    }

    setState(() => _isLoading = true);
    final String? error = await _sharedPred.register(username, password);
    setState(() => _isLoading = false);

    if (error == null) {
      _usernameController.clear();
      _passwordController.clear();
      await _checkLoginStatus();
    } else {
      _showError(error);
    }
  }

  /// Handle logout
  Future<void> _handleLogout() async {
    setState(() => _isLoading = true);
    await _sharedPred.logout();
    await _checkLoginStatus();
    setState(() => _isLoading = false);
  }

  /// Show error message
  void _showError(String message) {
    showCupertinoDialog(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: const Text("Error"),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Settings')),
      child: SafeArea(
        child:
            _isLoading
                ? const Center(child: CupertinoActivityIndicator())
                : _isLoggedIn
                ? _buildLoggedInUI()
                : _buildLoginRegisterUI(),
      ),
    );
  }

  /// UI for logged-in user
  Widget _buildLoggedInUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome, $_username!", style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          CupertinoButton.filled(
            onPressed: _handleLogout,
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  /// UI for login/register form
  Widget _buildLoginRegisterUI() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoTextField(
            controller: _usernameController,
            placeholder: "Username",
          ),
          const SizedBox(height: 10),
          CupertinoTextField(
            controller: _passwordController,
            placeholder: "Password",
            obscureText: true,
          ),
          const SizedBox(height: 20),
          CupertinoButton.filled(
            onPressed: _handleLogin,
            child: const Text("Login"),
          ),
          const SizedBox(height: 10),
          CupertinoButton(
            onPressed: _handleRegister,
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}
