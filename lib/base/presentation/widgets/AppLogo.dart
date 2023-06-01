import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Text(
      l10n!.appName,
      style: GoogleFonts.robotoCondensed(
        fontSize: 52,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
        fontStyle: FontStyle.italic
      )
    );
  }
}
