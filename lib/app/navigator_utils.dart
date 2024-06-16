import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppPage { pinyinConverter, settings, reorder, reorderDetails }

AppPage computeSelectedSection(BuildContext context) {
  final location = GoRouterState.of(context).uri.toString();

  if (location.startsWith('/pinyin-converter/')) {
    return AppPage.pinyinConverter;
  }
  if (location.startsWith('/settings/reorder-properties')) {
    return AppPage.reorder;
  }
  if (location.startsWith('/settings/reorder-units/') &&
      location.split('/')[3] != '') {
    return AppPage.reorderDetails;
  }
  if (location.startsWith('/settings/reorder-units')) {
    return AppPage.reorder;
  }
  if (location.startsWith('/settings')) {
    return AppPage.settings;
  }
  return AppPage.pinyinConverter;
}
