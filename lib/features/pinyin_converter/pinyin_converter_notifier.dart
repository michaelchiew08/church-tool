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

  String respondWithSampleText() {
    return '''
坡合蝴以少男蛋笔上 石呢了课停春谁交目苦棵母力元吃 间羽习 路写升品衣  读兑坡具成活石房杯害科穿对 皮放师吧玩像那具金爪兑或送麻位请故光 共秋九鸟向安的休条苦西笑鼻花戊  \n
住屋工风躲兄家师习拉南旦世知工爪木完鸡户  你进又片民旦流  是几元 日方自夏  乞亮植到圆友主现民植弓点路什这  王寺口  \n
别寸像日鼻步忍兔根卜话实布京安房笑不只打 古家面课连在那五娘页 急雪牛 奶对言  贝对女进助远羽结立喝抄丢西很左把 ''';
  }
}
