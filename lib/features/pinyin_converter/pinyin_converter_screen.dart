import 'package:church_tool/features/pinyin_converter/pinyin_converter.dart';
// import 'package:church_tool/features/sample_feature/sample_item_list_view.dart';
import 'package:church_tool/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PinyinConverterScreen extends HookConsumerWidget {
  const PinyinConverterScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(pinyinConverterNotifierProvider.notifier);
    final state = ref.watch(pinyinConverterNotifierProvider);

    final newTextFieldArea = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pinyin Converter'),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.list),
          //   onPressed: () {
          //     Navigator.restorablePushNamed(
          //       context,
          //       SampleItemListView.routeName,
          //     );
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: UniqueKey(),
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              controller: newTextFieldArea,
              decoration: const InputDecoration(
                labelText: 'Enter your text here for convertion',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    notifier.convertText(newTextFieldArea.text);
                    newTextFieldArea.clear();
                  },
                  child: const Text(
                    'Convert',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    notifier.clearState();
                    newTextFieldArea.clear();
                  },
                  child: const Text(
                    'Clear',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            Text(state),
          ],
        ),
      ),
    );
  }
}
