import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPref = FutureProvider<SharedPreferences>(
  (_) async => SharedPreferences.getInstance(),
);

final Map<Locale, String> mapLocale = {
  const Locale('zh'): const Locale('zh').languageCode,
  const Locale('en'): const Locale('en').languageCode,
};

class CurrentLocaleNotifier extends AsyncNotifier<Locale?> {
  static const _prefKey = 'language_code';
  static final provider = AsyncNotifierProvider<CurrentLocaleNotifier, Locale?>(
    CurrentLocaleNotifier.new,
  );

  @override
  Future<Locale?> build() async {
    final pref = await ref.watch(sharedPref.future);

    final savedLanguageCode = pref.getString(_prefKey);
    if (savedLanguageCode == null) {
      return null;
    }
    return mapLocale.keys.firstWhere(
      (element) => element.languageCode == savedLanguageCode,
      orElse: () => const Locale('zh'),
    );
  }

  /// Loads the User's locale
  Future<Locale> getLocaleData() async {
    final pref = await ref.watch(sharedPref.future);

    final savedLanguageCode = pref.getString(_prefKey);
    if (savedLanguageCode == null) {
      return const Locale('zh');
    } else {
      return Locale(savedLanguageCode);
    }
  }

  void set(Locale? value) {
    state = AsyncData(value);
    ref.read(sharedPref.future).then(
          (pref) => value == null
              ? pref.remove(_prefKey)
              : pref.setString(_prefKey, value.languageCode),
        );
  }
}

class CurrentThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  static const _prefKey = 'currentThemeMode';
  static final provider =
      AsyncNotifierProvider<CurrentThemeModeNotifier, ThemeMode>(
    CurrentThemeModeNotifier.new,
  );

  @override
  Future<ThemeMode> build() async {
    final pref = await ref.watch(sharedPref.future);
    return ThemeMode.values[pref.getInt(_prefKey) ?? 0];
  }

  void set(ThemeMode value) {
    state = AsyncData(value);
    ref
        .read(sharedPref.future)
        .then((pref) => pref.setInt(_prefKey, ThemeMode.values.indexOf(value)));
  }
}
