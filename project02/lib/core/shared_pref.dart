import 'package:flutter/material.dart';
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
    ThemeMode? theme,
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
      'theme': theme?.name ?? 'system',
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

  /// Removes the current user and all associated data
  Future<void> clearUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final String? currentUser = await getUsername();

    if (currentUser != null) {
      await prefs.remove(currentUser);
    }

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
    } else {
      favorites.remove(favorite);
    }

    userData['favorites'] = favorites;
    await prefs.setString(currentUser, jsonEncode(userData));
  }

  /// Clears the favorites list of the character
  Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? currentUser = await getUsername();
    if (currentUser == null) return;

    final String? userDataJson = prefs.getString(currentUser);
    if (userDataJson == null) return;

    final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
    userData['favorites'] = <String>[];
    await prefs.setString(currentUser, jsonEncode(userData));
  }

  /// Check if a character is a favorite
  Future<bool> isFavorite(String favorite) async {
    final favorites = await getFavorites();
    return favorites.contains(favorite);
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();

    // Get the current user
    final String? currentUser = await getUsername();
    if (currentUser == null) return;

    // Get the user data
    final String? userDataJson = prefs.getString(currentUser);
    if (userDataJson == null) return;

    // Parse favorites from JSON
    final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
    userData['theme'] = themeMode.name;
    await prefs.setString(currentUser, jsonEncode(userData));
  }

  Future<ThemeMode> getTheme() async {
    final prefs = await SharedPreferences.getInstance();

    // Get the current user
    final String? currentUser = await getUsername();
    if (currentUser == null) return ThemeMode.system;

    // Get the user data
    final String? userDataJson = prefs.getString(currentUser);
    if (userDataJson == null) return ThemeMode.system;

    // Parse favorites from JSON
    final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
    final themeString = userData['theme'] as String? ?? 'system';
    return _parseThemeMode(themeString);
  }

  /// Parse string to ThemeMode
  ThemeMode _parseThemeMode(String themeString) {
    switch (themeString.toLowerCase()) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }
}
