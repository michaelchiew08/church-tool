import 'package:church_tool/settings/settings.dart';
import 'package:church_tool/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({
    required this.isDrawerFixed,
    required this.openSearch,
    super.key,
  });

  final bool isDrawerFixed;
  final void Function() openSearch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headerDrawer = <Widget>[];

    final iconColor = getIconColor(Theme.of(context));

    final themeMode = ref.watch(CurrentThemeModeNotifier.provider);

    final title = Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (themeMode.value == ThemeMode.dark)
            SvgPicture.asset(
              'icons/app_logo_white.svg'.forWeb(web: kIsWeb),
              height: 70,
            ),
          if (themeMode.value == ThemeMode.light)
            SvgPicture.asset(
              'icons/app_logo_black.svg',
              height: 70,
            ),
          if (themeMode.value == ThemeMode.system)
            SvgPicture.asset(
              'icons/app_logo_white.svg',
              height: 70,
            ),
        ],
      ),
    );
    headerDrawer.add(
      isDrawerFixed
          ? InkWell(
              onTap: () => context.go('/'),
              child: title,
            )
          : title,
    );

    if (isDrawerFixed) {
      headerDrawer
        ..add(
          NavigationDrawerDestination(
            key: const ValueKey('drawerItem_search'),
            icon: Icon(Icons.search_outlined, color: iconColor),
            label: Text(AppLocalizations.of(context)!.searchTitle),
          ),
        )
        ..add(
          NavigationDrawerDestination(
            key: const ValueKey('drawerItem_settings'),
            icon: Icon(Icons.settings_outlined, color: iconColor),
            label: Text(AppLocalizations.of(context)!.settingsTitle),
          ),
        );
    }
    // This is just a empty place holderz
    headerDrawer.add(
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Divider(),
      ),
    );

    final conversionsOrderDrawer =
        ref.watch(PropertiesOrderNotifier.provider).valueOrNull;

    if (conversionsOrderDrawer == null) {
      return const SizedBox();
    }

    final propertyUiList = getPropertyUiList(context);
    final conversionDrawer = List<Widget>.filled(
      propertyUiList.length,
      const SizedBox(),
    );

    for (var i = 0; i < propertyUiList.length; i++) {
      final propertyUi = propertyUiList[i];
      conversionDrawer[conversionsOrderDrawer[i]] = NavigationDrawerDestination(
        key: ValueKey('drawerItem_${reversePageNumberListMap[i]}'),
        icon: Icon(propertyUi.imageIcon),
        label: Text(propertyUi.name),
      );
    }

    // How many NavigationDrawerDestination elements are there in the drawer
    final headerElements =
        headerDrawer.whereType<NavigationDrawerDestination>().toList().length;

    return NavigationDrawer(
      selectedIndex: pathToNavigationIndex(
        context,
        isDrawerFixed: isDrawerFixed,
        conversionsOrderDrawer: conversionsOrderDrawer,
      ),
      onDestinationSelected: (int selectedPage) {
        if (selectedPage >= headerElements) {
          switch (selectedPage) {
            case 0:
            case 1:
            case 2:
              context.goNamed('pinyin-converter');
          }
          // );
          if (!isDrawerFixed) {
            Navigator.of(context).pop();
          }
        } else if (headerElements == 2) {
          switch (selectedPage) {
            case 0:
              openSearch();
            case 1:
              if (!isDrawerFixed) {
                Navigator.of(context).pop();
              }
              context.goNamed('settings');
          }
        } else if (headerElements == 1) {
          if (!isDrawerFixed) {
            Navigator.of(context).pop();
          }
          // context.goNamed('settings');
        }
      },
      children: <Widget>[
        ...headerDrawer,
        ...conversionDrawer,
      ],
    );
  }
}

int pathToNavigationIndex(
  BuildContext context, {
  required bool isDrawerFixed,
  required List<int> conversionsOrderDrawer,
}) {
  // final location = GoRouterState.of(context).uri.toString();
  // 3 elements in the header
  if (isDrawerFixed) {
    // if (location.startsWith('/conversions/')) {
    //   return conversionsOrderDrawer[computeSelectedConversionPage(context)!] +
    //       3;
    // } else {
    //   return 2; // Settings
    // }
    return 2;
  }
  // 1 element in the header
  else {
    // if (location.startsWith('/conversions/')) {
    //   return conversionsOrderDrawer[computeSelectedConversionPage(context)!] +
    //       1;
    // } else {
    //   return 0; // Settings
    // }
    return 0;
  }
}
