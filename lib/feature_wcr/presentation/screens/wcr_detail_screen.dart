import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class WCRDetailScreen extends StatefulWidget {
  const WCRDetailScreen({super.key, required this.wcrId});
  final String wcrId;

  @override
  State<WCRDetailScreen> createState() => _WCRDetailScreenState();
}

class _WCRDetailScreenState extends State<WCRDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          l10n!.wcr_detail,
          style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: Center(
        child: Text(
          "WCR DETAIL SCREEN",
          style: theme.textTheme.headlineMedium,
        ),
      ),
    );
  }
}
