import 'package:flutter/material.dart';
import 'package:project02/core/shared_pref.dart';

///
/// SharedState class
/// Manage the favorites to recieve updates
///
/// @author: Jason Chen
/// @version: 1.0.0
/// @since: 2025-03-09
///

class SharedState {
  static final SharedPref _sharedPref = SharedPref();
  static final ValueNotifier<String?> currentUser = ValueNotifier<String?>(
    null,
  );
  static final ValueNotifier<List<String>> favoriteIds =
      ValueNotifier<List<String>>([]);
  static final ValueNotifier<ThemeMode> theme = ValueNotifier<ThemeMode>(
    ThemeMode.system,
  );

  /// Load initial state from SharedPref
  static Future<void> loadInitialState() async {
    final user = await _sharedPref.getUsername();
    currentUser.value = user;

    if (user != null) {
      favoriteIds.value = await _sharedPref.getFavorites();

      theme.value = await _sharedPref.getTheme();
    } else {
      favoriteIds.value = [];
      theme.value = ThemeMode.light;
    }
  }

  static Future<void> setTheme(ThemeMode themeMode) async {
    theme.value = themeMode;
    await _sharedPref.setTheme(themeMode);
  }

  /// SharedPref login wrapper with ValueNotifier updates
  static Future<String?> login(String username, String password) async {
    final result = await _sharedPref.login(username, password);
    if (result == null) {
      currentUser.value = username;
      favoriteIds.value = await _sharedPref.getFavorites();
      theme.value = await _sharedPref.getTheme();
    }
    return result;
  }

  /// SharedPref register wrapper with ValueNotifier updates
  static Future<String?> register(String username, String password) async {
    final result = await _sharedPref.register(username, password);
    if (result == null) {
      currentUser.value = username;
      favoriteIds.value = [];
    }
    return result;
  }

  /// SharedPref logout wrapper with ValueNotifier updates
  static Future<void> logout() async {
    await _sharedPref.logout();
    currentUser.value = null;
    favoriteIds.value = [];
    theme.value = ThemeMode.system;
  }

  /// SharedPref toggleFavorite wrapper with ValueNotifier updates
  static Future<void> toggleFavorite(String id) async {
    if (currentUser.value == null) return;
    await _sharedPref.setFavorite(id);
    final updatedFavorites = await _sharedPref.getFavorites();
    favoriteIds.value = updatedFavorites;
  }

  // SharedPref isFavorite wrapper
  static Future<bool> isFavorite(String id) async {
    return _sharedPref.isFavorite(id);
  }

  static Future<void> clearFavorites() async {
    if (currentUser.value == null) return;
    await _sharedPref.clearFavorites();
    favoriteIds.value = [];
  }

  static Future<void> clearUsername() async {
    if (currentUser.value == null) return;
    await _sharedPref.clearUsername();
    currentUser.value = null;
    favoriteIds.value = [];
    theme.value = ThemeMode.system;
  }
}
