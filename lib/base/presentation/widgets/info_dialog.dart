import 'package:borlago/base/presentation/widgets/dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<dynamic> infoDialog({
  required BuildContext context,
  required String info,
  void Function()? okAction
}) {
  final theme = Theme.of(context);
  final l10n = AppLocalizations.of(context);

  return showDialog(
      context: context,
      builder: (context) =>  SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: theme.colorScheme.surface,
        contentPadding: const EdgeInsets.all(24),
        children: [
          Text(
            info,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8,),
          SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                if(okAction != null) {
                  okAction();
                }
              },
              child: DialogButton(btnText: l10n!.btn_ok),
          ),
        ],
      )
  );
}