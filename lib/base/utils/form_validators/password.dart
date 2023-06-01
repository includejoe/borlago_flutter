import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordValidator {
  PasswordValidator(this.context, this.confirm);

  final BuildContext context;
  final bool confirm;

  String? call(String value, String? confirmValue) {
    final l10n = AppLocalizations.of(context);

    if (confirm) {
      if(value.isEmpty) {
        return l10n!.err_empty_field;
      } else if(value.length < 6) {
        return l10n!.err_min_password;
      } else if(value != confirmValue) {
        return l10n!.err_password_mismatch;
      }
    } else if(value.isEmpty) {
      return l10n!.err_empty_field;
    } else if(value.length < 6) {
      return l10n!.err_min_password;
    }
    return null;
  }
}