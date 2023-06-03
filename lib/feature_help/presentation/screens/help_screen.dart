import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.scaffoldBackgroundColor,
        ),
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(
            "HELP SCREEN",
            style: theme.textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
