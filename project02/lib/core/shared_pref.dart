import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

///
/// SharedPref class for handling shared preferences
///
/// @author Jason Chen
/// @version 1.0.0
/// @since 2025-03-07
///

class SharedPref {
  /// Get logged-in username
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentUser');
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  /// Register a new account
  Future<String?> register(
    String username,
    String password, {
    List<String>? favorites,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Check if an account already exists
    if (prefs.containsKey(username)) {
      return "Username already exists. Please log in.";
    }

    // Create a new account
    final userData = {
      'password': password,
      'favorites': favorites ?? <String>[],
    };
    await prefs.setString(username, jsonEncode(userData));

    // Log in the new user
    await prefs.setString('currentUser', username);
    await prefs.setBool('isLoggedIn', true);
    return null;
  }

  /// Login with stored credentials
  Future<String?> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // Check if an account exists
    final String? userDataJson = prefs.getString(username);
    if (userDataJson == null) {
      return "No account exists. Please register.";
    }

    // Check if the password is correct
    final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
    if (userData['password'] != password) {
      return "Invalid password.";
    }

    // Log in the user
    await prefs.setString('currentUser', username);
    await prefs.setBool('isLoggedIn', true);
    return null;
  }

  /// Logout, removes pref so it returns null
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
    await prefs.remove('isLoggedIn');
  }

  /// Get favorites for the logged-in user
  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    // Get the current user
    final String? currentUser = await getUsername();
    if (currentUser == null) return [];

    // Get the user data
    final String? userDataJson = prefs.getString(currentUser);
    if (userDataJson == null) return [];

    // Parse favorites from JSON
    final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
    return List<String>.from(userData['favorites'] as List);
  }

  /// Add a favorite for the logged-in user
  Future<void> setFavorite(String favorite) async {
    final prefs = await SharedPreferences.getInstance();

    // Get the current user
    final String? currentUser = await getUsername();
    if (currentUser == null) return;

    // Get the user data
    final String? userDataJson = prefs.getString(currentUser);
    if (userDataJson == null) return;

    // Parse favorites from JSON
    final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
    final favorites = List<String>.from(userData['favorites'] as List);

    // Add the favorite if it doesn't exist
    if (!favorites.contains(favorite)) {
      favorites.add(favorite);
      userData['favorites'] = favorites;
    } else {
      favorites.remove(favorite);
      userData['favorites'] = favorites;
    }

    await prefs.setString(currentUser, jsonEncode(userData));
  }

  /// Check if a character is a favorite for the logged-in user
  Future<bool> isFavorite(String favorite) async {
    final prefs = await SharedPreferences.getInstance();

    // Get the current user
    final String? currentUser = await getUsername();
    if (currentUser == null) return false;

    // Get the user data
    final String? userDataJson = prefs.getString(currentUser);
    if (userDataJson == null) return false;

    // Parse favorites from JSON
    final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
    final favorites = List<String>.from(userData['favorites'] as List);

    // Check if the favorite exists
    return favorites.contains(favorite);
  }
}
