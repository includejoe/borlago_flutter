import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextValidator {
  TextValidator(this.context);

  final BuildContext context;

  String? call(String value) {
    final l10n = AppLocalizations.of(context);

    if(value.isEmpty) {
      return l10n!.err_empty_field;
    }
    return null;
  }
}