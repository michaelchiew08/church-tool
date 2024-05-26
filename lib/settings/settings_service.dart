import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
  }

  /// Loads the User's locale
  Future<Locale> getLocaleData() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code');
    if (languageCode == null) {
      return const Locale('zh');
    } else {
      return Locale(languageCode);
    }
  }

  /// Update locale in Shared Preferences
  Future<void> updateLocaleData(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
  }
}
