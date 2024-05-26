import 'package:church_tool/features/pinyin_converter/pinyin_converter.dart';
import 'package:church_tool/features/pinyin_converter/pinyin_converter_notifier.dart';
import 'package:church_tool/settings/settings_controller.dart';
// import 'package:church_tool/features/sample_feature/sample_item_list_view.dart';
import 'package:church_tool/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

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

    return Scaffold(
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
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                key: UniqueKey(),
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                controller: newTextFieldArea,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.converterTextField,
                  labelStyle: const TextStyle(height: 0),
                ),
              ),
              const SizedBox(),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        notifier.convertText(newTextFieldArea.text);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.convertButton,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        notifier.clearState();
                        newTextFieldArea.clear();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.clearButton,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ),
              Text(state),
            ],
          ),
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                style: Theme.of(context).textTheme.bodySmall,
                children: <InlineSpan>[
                  if (settingsController.locale.languageCode == 'en')
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child:
                          Text(AppLocalizations.of(context)!.madeWithLoveText),
                    ),
                  const WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    baseline: TextBaseline.alphabetic,
                    child: LinkButton(
                      urlLabel: 'Michael Chiew',
                      url: 'https://github.com/michaelchiew08',
                    ),
                  ),
                  if (settingsController.locale.languageCode == 'zh')
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child:
                          Text(AppLocalizations.of(context)!.madeWithLoveText),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LinkButton extends StatelessWidget {
  const LinkButton({
    required this.urlLabel,
    required this.url,
    super.key,
  });

  final String urlLabel;
  final String url;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);

    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        minimumSize: Size.zero,
        textStyle: Theme.of(context).textTheme.bodySmall,
      ),
      onPressed: () {
        _launchUrl(url);
      },
      child: Text(urlLabel),
    );
  }
}
