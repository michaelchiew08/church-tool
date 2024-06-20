import 'package:church_tool/app/base_scaffold.dart';
import 'package:church_tool/features/pinyin_converter/pinyin_converter.dart';
import 'package:church_tool/features/pinyin_converter/pinyin_converter_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PinyinConverterScreen extends HookConsumerWidget {
  const PinyinConverterScreen({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(pinyinConverterNotifierProvider.notifier);
    final state = ref.watch(pinyinConverterNotifierProvider);

    final newTextFieldArea = useTextEditingController();

    return BaseScaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeTitle),
      ),
      body: Container(
        padding: const EdgeInsets.all(16).copyWith(bottom: 24, top: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
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
              const SizedBox(height: 20),
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
              const SizedBox(height: 40),
              const Center(child: PinyinChoiceSegmentedButton()),
              const SizedBox(height: 20),
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
              SelectionArea(
                child: Text(state),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PinyinChoiceSegmentedButton extends StatefulHookConsumerWidget {
  const PinyinChoiceSegmentedButton({super.key});

  @override
  ConsumerState<PinyinChoiceSegmentedButton> createState() =>
      _SingleChoiceState();
}

class _SingleChoiceState extends ConsumerState<PinyinChoiceSegmentedButton> {
  PinyinFormatType pinyinFormatTypeView = PinyinFormatType.withoutTone;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(pinyinToneNotifierProvider.notifier);
    final state = ref.watch(pinyinToneNotifierProvider);

    return SegmentedButton<PinyinFormatType>(
      segments: <ButtonSegment<PinyinFormatType>>[
        ButtonSegment<PinyinFormatType>(
          value: PinyinFormatType.withoutTone,
          label: Text(AppLocalizations.of(context)!.pinyinWithoutTone),
        ),
        ButtonSegment<PinyinFormatType>(
          value: PinyinFormatType.withToneMark,
          label: Text(AppLocalizations.of(context)!.pinyinWithTone),
        ),
        ButtonSegment<PinyinFormatType>(
          value: PinyinFormatType.withToneNumber,
          label: Text(AppLocalizations.of(context)!.pinyinWithToneNumber),
        ),
      ],
      selected: <PinyinFormatType>{state},
      onSelectionChanged: notifier.respondPinyinFormatType,
    );
  }
}
