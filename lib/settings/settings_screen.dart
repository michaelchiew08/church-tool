import 'package:church_tool/app/base_scaffold.dart';
import 'package:church_tool/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({required this.settingsController, super.key});

  static const routeName = '/settings';

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      settingsController: settingsController,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
      ),
      body: ListView(
        children: [
          CustomListTile(
            title: AppLocalizations.of(context)!.settingsThemeTitle,
            leading: const Icon(Icons.contrast),
            trailing: DropdownButton<ThemeMode>(
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
          ),
          CustomListTile(
            title: AppLocalizations.of(context)!.settingsLanguageTitle,
            leading: const Icon(Icons.translate),
            trailing: DropdownButton<Locale>(
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
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.title,
    required this.trailing,
    this.subtitle,
    this.leading,
    super.key,
  });

  final String title;
  final Widget trailing;
  final String? subtitle;
  final Icon? leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(title),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              style: const TextStyle(fontSize: 12),
            ),
      trailing: trailing,
      onTap: () {
        Posthog().capture(
          eventName: 'title',
          properties: {
            'clicked': true,
          },
        );
      },
    );
  }
}
