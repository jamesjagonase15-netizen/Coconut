import 'package:flutter/material.dart';

import '../../../../core/localization/app_language.dart';
import '../../../../core/localization/app_translations.dart';
import '../../../../core/services/language_preferences_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AppLanguage _selectedLanguage = AppLanguage.english;
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final language = await LanguagePreferencesService.load();
    if (mounted) {
      setState(() {
        _selectedLanguage = language;
        _isLoading = false;
      });
    }
  }

  Future<void> _selectLanguage(AppLanguage language) async {
    setState(() => _selectedLanguage = language);
    await LanguagePreferencesService.save(language);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.tr('language_saved'))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF1B5E20),
        title: Text(
          context.tr('settings'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  context.tr('language'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: AppLanguage.values.map((language) {
                      return RadioListTile<AppLanguage>(
                        value: language,
                        groupValue: _selectedLanguage,
                        title: Text(language.label),
                        subtitle: Text(language.code.toUpperCase()),
                        activeColor: const Color(0xFF2E7D32),
                        onChanged: (value) {
                          if (value != null) {
                            _selectLanguage(value);
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  context.tr('language_help'),
                  style: TextStyle(color: Color(0xFF546E7A), height: 1.5),
                ),
              ],
            ),
    );
  }
}
