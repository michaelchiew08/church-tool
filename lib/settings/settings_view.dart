import 'package:church_tool/app/base_scaffold.dart';
import 'package:church_tool/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({required this.settingsController, super.key});

  static const routeName = '/settings';

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      settingsController: settingsController,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.settingsThemeTitle),
                DropdownButton<ThemeMode>(
                  // Read the selected themeMode from the controller
                  value: settingsController.themeMode,
                  // Call the updateThemeMode method any time the user selects
                  // a theme.
                  onChanged: settingsController.updateThemeMode,
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text(
                        AppLocalizations.of(context)!.settingsThemeSystem,
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(
                        AppLocalizations.of(context)!.settingsThemeLight,
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(
                        AppLocalizations.of(context)!.settingsThemeDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.settingsLanguageTitle),
                DropdownButton<Locale>(
                  value: settingsController.locale,
                  onChanged: settingsController.updateLocale,
                  items: const [
                    DropdownMenuItem(
                      value: Locale('zh'),
                      child: Text('简体中文'),
                    ),
                    DropdownMenuItem(
                      value: Locale('en'),
                      child: Text('English'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
