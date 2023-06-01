import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailValidator {
  EmailValidator(this.context);

  final BuildContext context;

  String? call(String value) {
    final l10n = AppLocalizations.of(context);
    bool isValid = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$',).hasMatch(value);

    if(value.isEmpty) {
      return l10n!.err_empty_field;
    } else if(!isValid) {
      return l10n!.err_invalid_email;
    }
    return null;
  }
}