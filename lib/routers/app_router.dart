import 'package:church_tool/app/app.dart';
import 'package:church_tool/features/features.dart';
import 'package:church_tool/settings/settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, _) => const SplashScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return AppScaffold(
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/pinyin-converter',
            name: 'pinyin-converter',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: PinyinConverterScreen(),
              );
            },
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      // Bypass splashscreen if variables are already loaded
      if (state.uri.toString() == '/') {
        return '/pinyin-converter';
      }
      return null;
    },
    errorBuilder: (context, state) => const ErrorScreen(),
  ),
);
