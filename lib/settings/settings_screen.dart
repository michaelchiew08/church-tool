import 'package:church_tool/app/base_scaffold.dart';
import 'package:church_tool/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapTheme = {
      ThemeMode.system: ThemeMode.system,
      ThemeMode.dark: ThemeMode.dark,
      ThemeMode.light: ThemeMode.light,
    };

    return BaseScaffold(
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
              value: mapTheme[
                  ref.watch(CurrentThemeModeNotifier.provider).valueOrNull ??
                      0],
              // Call the updateThemeMode method any time the user selects
              // a theme.
              onChanged: (ThemeMode? themeMode) {
                ref.read(CurrentThemeModeNotifier.provider.notifier).set(
                      mapTheme.keys
                          .where((key) => mapTheme[key] == themeMode)
                          .single,
                    );
              },
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
              value: ref.watch(CurrentLocaleNotifier.provider).valueOrNull ??
                  const Locale('zh'),
              onChanged: (Locale? locale) {
                if (locale != null) {
                  ref.read(CurrentLocaleNotifier.provider.notifier).set(
                        mapLocale.keys
                            .where(
                              (key) => mapLocale[key] == locale.languageCode,
                            )
                            .single,
                      );
                }
              },
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
