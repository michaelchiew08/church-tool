import 'package:church_tool/routers/routers.dart';
import 'package:church_tool/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:universal_io/io.dart';
// import 'package:posthog_flutter/posthog_flutter.dart';

/// The Widget that configures your application.
class ChurchTool extends ConsumerWidget {
  const ChurchTool({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController
    // for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return Consumer(
      builder: (context, ref, child) {
        final settingsLocale =
            ref.watch(CurrentLocaleNotifier.provider).valueOrNull;

        // final deviceLocaleLanguageCode = Platform.localeName.split('_')[0];
        Locale appLocale;

        if (settingsLocale != null) {
          appLocale = settingsLocale;
        } else {
          appLocale = const Locale('zh');
        }

        final appRouter = ref.read(routerProvider);

        return MaterialApp.router(
          routeInformationProvider: appRouter.routeInformationProvider,
          routeInformationParser: appRouter.routeInformationParser,
          routerDelegate: appRouter.routerDelegate,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: appLocale,
          supportedLocales: mapLocale.keys,
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: ref.watch(CurrentThemeModeNotifier.provider).valueOrNull ??
              ThemeMode.system,
          restorationScopeId: 'app',
        );
      },
    );
  }
}
