import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:borlago/feature_authentication/presentation/screens/login_screen.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<dynamic> infoDialog({
  required BuildContext context,
  required String info,
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
          )
        ],
      )
  );
}