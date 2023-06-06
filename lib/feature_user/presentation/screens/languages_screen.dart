import 'package:borlago/base/providers/localization_provider.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/feature_user/presentation/widgets/text_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final languages = <Widget>[
      TextItem(
        onTap: () {
          context.read<LocalizationProvider>().setLocale(
            locale: const Locale.fromSubtags(languageCode: "en")
          );
          Navigator.pop(context);
        },
        text: Constants.languages[0],
      ),
      TextItem(
        onTap: () {
          context.read<LocalizationProvider>().setLocale(
            locale: const Locale.fromSubtags(languageCode: "fr")
          );
          Navigator.pop(context);
        },
        text: Constants.languages[1]
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          l10n!.lbl_languages,
          style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)
            ),
            color: theme.scaffoldBackgroundColor,
          ),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: languages.length,
            itemBuilder: (context, index) {
              return languages[index];
            }
          )
      ),
    );
  }
}
