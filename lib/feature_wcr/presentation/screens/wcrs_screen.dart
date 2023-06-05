import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WCRsScreen extends StatelessWidget {
  const WCRsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        automaticallyImplyLeading: false,
        title: Text(
          l10n!.wcrs,
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
        child: Center(
          child: Text(
            "WCRs SCREEN",
            style: theme.textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
