import 'package:church_tool/app/base_scaffold.dart';
import 'package:church_tool/features/pinyin_converter/pinyin_converter.dart';
import 'package:church_tool/features/pinyin_converter/pinyin_converter_notifier.dart';
import 'package:church_tool/settings/settings_controller.dart';
// import 'package:church_tool/features/sample_feature/sample_item_list_view.dart';
import 'package:church_tool/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PinyinConverterScreen extends HookConsumerWidget {
  const PinyinConverterScreen({
    required this.settingsController,
    super.key,
  });

  static const routeName = '/';
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(pinyinConverterNotifierProvider.notifier);
    final state = ref.watch(pinyinConverterNotifierProvider);

    final newTextFieldArea = useTextEditingController();
    final selectableTextController = useTextEditingController();

    return BaseScaffold(
      settingsController: settingsController,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeTitle),
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
            tooltip: AppLocalizations.of(context)!.settingsTitle,
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16).copyWith(bottom: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.gettingStartedText,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      newTextFieldArea.text = notifier.respondWithSampleText();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.deepPurple),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.generateTextButton,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              TextField(
                key: UniqueKey(),
                maxLines: 6,
                keyboardType: TextInputType.multiline,
                controller: newTextFieldArea,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.converterTextField,
                  labelStyle: const TextStyle(height: 0),
                ),
              ),
              const SizedBox(),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: ElevatedButton(
                        onPressed: () {
                          notifier.convertText(newTextFieldArea.text);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.convertButton,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: ElevatedButton(
                        onPressed: () {
                          notifier.clearState();
                          newTextFieldArea.clear();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.clearButton,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SelectableText(
                state,
                onTap: () async {
                  final selectedText = selectableTextController.selection
                      .textInside(selectableTextController.text);
                  const copyAction = PopupMenuItem<String>(
                    value: 'copy',
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.content_copy),
                        SizedBox(width: 8),
                        Text('Copy'),
                      ],
                    ),
                  );
                  final selectedAction = await showMenu<String>(
                    context: context,
                    position: RelativeRect.fill,
                    items: <PopupMenuEntry<String>>[copyAction],
                  );
                  if (selectedAction == 'copy') {
                    await Clipboard.setData(ClipboardData(text: selectedText));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
