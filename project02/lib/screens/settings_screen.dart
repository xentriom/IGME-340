import 'package:flutter/cupertino.dart';
import 'package:project02/core/shared_pref.dart';
import 'package:project02/core/shared_state.dart';

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
    final String? error = await SharedState.login(username, password);
    setState(() => _isLoading = false);

    if (error == null) {
      _usernameController.clear();
      _passwordController.clear();
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
    final String? error = await SharedState.register(username, password);
    setState(() => _isLoading = false);

    if (error == null) {
      _usernameController.clear();
      _passwordController.clear();
    } else {
      _showError(error);
    }
  }

  /// Handle logout
  Future<void> _handleLogout() async {
    setState(() => _isLoading = true);
    await SharedState.logout();
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
        middle: Text(_isLoggedIn ? 'Interastral Guide' : ''),
      ),
      child: SafeArea(
        child: ValueListenableBuilder(
          // Listen to changes in currentUser
          valueListenable: SharedState.currentUser,
          builder: (context, username, child) {
            _username = username;
            _isLoggedIn = username != null;

            // Loading? Display loading indicator
            // Logged in? Display logged in UI
            // Show login? Display login form
            // Show register? Display register form
            return _isLoading
                ? const Center(child: CupertinoActivityIndicator())
                : _isLoggedIn
                ? _buildLoggedInUI()
                : _showLogin
                ? _buildLoginUI()
                : _buildRegisterUI();
          },
        ),
      ),
    );
  }

  /// UI for logged-in user
  Widget _buildLoggedInUI() {
    return Container(
      color: CupertinoColors.systemGroupedBackground,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            // Profile Header (Rounded)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: CupertinoColors.systemGrey,
                    ),
                    child: Center(
                      child: Text(
                        _username![0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _username ?? 'Guest',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.black,
                        ),
                      ),
                      Text(
                        'Interastral Guide Account',
                        style: TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: CupertinoListSection.insetGrouped(
                margin: EdgeInsets.zero,
                backgroundColor: CupertinoColors.systemGroupedBackground,
                children: [
                  CupertinoListTile(
                    leading: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        CupertinoIcons.book_fill,
                        color: CupertinoColors.white,
                      ),
                    ),
                    title: const Text('About'),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                  CupertinoListTile(
                    leading: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemRed,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        CupertinoIcons.bell_fill,
                        color: CupertinoColors.white,
                      ),
                    ),
                    title: const Text('Notifications'),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                  CupertinoListTile(
                    leading: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: CupertinoColors.activeBlue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        CupertinoIcons.sun_max_fill,
                        color: CupertinoColors.white,
                      ),
                    ),
                    title: const Text('Display & Brightness'),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: CupertinoListSection.insetGrouped(
                margin: EdgeInsets.zero,
                backgroundColor: CupertinoColors.systemGroupedBackground,
                children: [
                  CupertinoListTile(
                    leading: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        CupertinoIcons.doc_fill,
                        color: CupertinoColors.white,
                      ),
                    ),
                    title: const Text('Legal & Regulatory'),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Column(
              spacing: 16,
              children: [
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(10),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Reset Bookmarks',
                        style: TextStyle(
                          fontSize: 17,
                          color: CupertinoTheme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(10),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Delete Account',
                        style: TextStyle(
                          fontSize: 17,
                          color: CupertinoColors.destructiveRed,
                        ),
                      ),
                    ],
                  ),
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(10),
                  onPressed: _handleLogout,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 17,
                          color: CupertinoColors.destructiveRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// UI for login form
  Widget _buildLoginUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                onTap:
                    () => setState(() {
                      _showLogin = false;
                      _passwordController.clear();
                    }),
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
            maxLength: 8,
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
            maxLength: 12,
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
                onTap:
                    () => setState(() {
                      _showLogin = true;
                      _agreeToTerms = false;
                      _passwordController.clear();
                    }),
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
