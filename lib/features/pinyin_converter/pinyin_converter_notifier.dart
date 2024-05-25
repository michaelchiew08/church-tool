import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lpinyin/lpinyin.dart';

final pinyinConverterNotifierProvider =
    NotifierProvider<PinyinConverterNotifier, String>(
  PinyinConverterNotifier.new,
);

class PinyinConverterNotifier extends Notifier<String> {
  @override
  String build() => '';

  void convertText(String text) {
    if (state.isNotEmpty) {
      clearState();
    }

    const ls = LineSplitter();
    final linesOfText = ls.convert(text);
    for (final element in linesOfText) {
      state = '$state\n${titleCase(
        PinyinHelper.getPinyin(
          element,
        ),
      )}';
    }
  }

  void clearState() {
    state = '';
  }

  /// Title case a word.
  String titleCase(String str) {
    final splitStr = str.toLowerCase().split(' ');
    for (var i = 0; i < splitStr.length; i++) {
      // Check for the first character in the string is not empty
      if (splitStr[i].isNotEmpty) {
        // You do not need to check if i is larger than splitStr length, as your
        // for does that for you
        // Assign it back to the array
        splitStr[i] = splitStr[i][0].toUpperCase() + splitStr[i].substring(1);
      }
    }
    // Directly return the joined string
    return splitStr.join(' ');
  }

  String numberOfLines(String str) {
    return ('\n'.allMatches(str).length + 1).toString();
  }
}
