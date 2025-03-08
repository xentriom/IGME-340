import 'package:flutter/cupertino.dart';
import 'package:project02/core/shared_pref.dart';

///
/// Settings Screen
/// Handles login, registration, settings
///
/// @author: Jason Chen
/// @version: 1.0.0
/// @since: 2025-03-07
///

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
  bool _showLogin = true;
  bool _agreeToTerms = false;
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
      navigationBar: CupertinoNavigationBar(
        middle: Text(_isLoggedIn ? "Settings" : " "),
      ),
      child: SafeArea(
        child:
            _isLoading
                ? const Center(child: CupertinoActivityIndicator())
                : _isLoggedIn
                ? _buildLoggedInUI()
                : _showLogin
                ? _buildLoginUI()
                : _buildRegisterUI(),
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

  /// UI for login form
  Widget _buildLoginUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Login",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.darkBackgroundGray,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Please sign in to continue",
            style: TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
          ),
          const SizedBox(height: 24),
          CupertinoTextField(
            controller: _usernameController,
            placeholder: "Username",
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.systemGrey4),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 12),
          CupertinoTextField(
            controller: _passwordController,
            placeholder: "Password",
            obscureText: true,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.systemGrey4),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton.filled(
              onPressed: _handleLogin,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: const Text("Login", style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _showLogin = false),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 14,
                    color: CupertinoTheme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// UI for register form
  Widget _buildRegisterUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Create Account",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          ),
          const SizedBox(height: 24),
          CupertinoTextField(
            controller: _usernameController,
            placeholder: "Username",
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.systemGrey4),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 12),
          CupertinoTextField(
            controller: _passwordController,
            placeholder: "Password",
            obscureText: true,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.systemGrey4),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
                child: CupertinoCheckbox(
                  value: _agreeToTerms,
                  onChanged:
                      (bool? value) =>
                          setState(() => _agreeToTerms = value ?? false),
                  activeColor: CupertinoTheme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  "By proceeding, you acknowledge that all data stored using shared preferences is not secure.",
                  style: const TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton.filled(
              onPressed: _agreeToTerms ? _handleRegister : null,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: const Text("Sign up", style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account? ",
                style: TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _showLogin = true),
                child: Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 14,
                    color: CupertinoTheme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
