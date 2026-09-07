import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../localization/app_language.dart';

/// Stores the user's selected app language on the device.
abstract final class LanguagePreferencesService {
  static const _languageKey = 'selected_language';
  static final SharedPreferencesAsync _preferences = SharedPreferencesAsync();
  static final ValueNotifier<AppLanguage> current =
      ValueNotifier(AppLanguage.english);

  static Future<AppLanguage> load() async {
    final code = await _preferences.getString(_languageKey);
    final language = AppLanguage.fromCode(code);
    current.value = language;
    return language;
  }

  static Future<void> save(AppLanguage language) async {
    current.value = language;
    await _preferences.setString(_languageKey, language.code);
  }
}
