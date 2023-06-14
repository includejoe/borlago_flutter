import 'package:borlago/base/presentation/widgets/dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<dynamic> confirmationDialog({
  required BuildContext context,
  required String title,
  required void Function() yesAction
}) {
  final theme = Theme.of(context);
  final l10n = AppLocalizations.of(context);

  return showDialog(
      context: context,
      builder: (context) =>  SimpleDialog(
        title: Center(
          child: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary
            ),
            textAlign: TextAlign.center
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: theme.colorScheme.surface,
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              yesAction();
            },
            child: DialogButton(btnText: l10n!.btn_yes),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Text(
                l10n.btn_no,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
              ),),
            )
          )
        ],
      )
  );
}