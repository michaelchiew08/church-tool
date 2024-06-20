import 'package:church_tool/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Saves the key value with SharedPreferences
Future<void> saveSettings(String key, dynamic value) async {
  final prefs = await SharedPreferences.getInstance();
  if (value is bool) {
    await prefs.setBool(key, value);
  } else if (value is int) {
    await prefs.setInt(key, value);
  } else if (value is String) {
    await prefs.setString(key, value);
  } else if (value is double) {
    await prefs.setDouble(key, value);
  } else if (value is List<String>) {
    await prefs.setStringList(key, value);
  }
}

/// Maps a string (path of the url) to a number value. This should be in the
/// same order as in property_unit_list.dart
const Map<String, int> pageNumberMap = {
  'pinyin-converter': 0,
  //'new-feature': 1,
};

/// Contains the same information of [pageNumberMap] but reversed. So I can
/// access to the strings faster.
final List<String> reversePageNumberListMap = pageNumberMap.keys.toList();

Color getIconColor(ThemeData theme) =>
    theme.brightness == Brightness.light ? Colors.black45 : Colors.white70;

void updateNavBarColor(ColorScheme colorscheme) {
  final mySystemTheme = SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: ElevationOverlay.applySurfaceTint(
      colorscheme.surface,
      colorscheme.surfaceTint,
      3,
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
}

///

/// PROPERTYX stands for PROPERTY extended and want to extends the PROPERTY enum
/// defined in units_converter package
enum PROPERTYX {
  pinyinConverter,
  newFeature,
}

class PropertyUi {
  PropertyUi(this.property, this.name, this.imageIcon);

  final PROPERTYX property;

  /// human readable name
  final String name;
  final IconData imageIcon;
}

/// This will return the list of [PropertyUi], an objext that contains all
/// the data regarding the displaying of the property all over the app.
/// From this List depends also other functions.
List<PropertyUi> getPropertyUiList(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  //The order is important!
  return [
    PropertyUi(
      PROPERTYX.pinyinConverter,
      l10n.homeTitle,
      Icons.language,
    ),
    // PropertyUi(
    //   PROPERTYX.newFeature,
    //   l10n.settingsTitle,
    //   Icons.settings,
    // ),
  ];
}

class PropertiesOrderNotifier extends AsyncNotifier<List<int>> {
  static final provider =
      AsyncNotifierProvider<PropertiesOrderNotifier, List<int>>(
    PropertiesOrderNotifier.new,
  );

  @override
  Future<List<int>> build() async {
    final temp = List.generate(19, (index) => index);
    final stringList =
        (await ref.read(sharedPref.future)).getStringList('orderDrawer');
    if (stringList != null) {
      final len = stringList.length;
      for (var i = 0; i < len; i++) {
        temp[i] = int.parse(stringList[i]);
      }
      // If new units of measurement will be added, the following 2
      // lines of code ensure that everything will works fine
      for (var i = len; i < temp.length; i++) {
        temp[i] = i;
      }
    }
    return temp;
  }
}
