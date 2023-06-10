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
              child: Center(
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child: Center(
                      child: Text(
                        l10n!.btn_ok,
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                ),
              )
          ),
        ],
      )
  );
}