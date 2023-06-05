import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:borlago/feature_authentication/presentation/screens/login_screen.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<dynamic> confirmLogoutDialog(BuildContext context) {
  final theme = Theme.of(context);
  final l10n = AppLocalizations.of(context);

  return showDialog(
      context: context,
      builder: (context) =>  SimpleDialog(
        title: Center(
          child: Text(
            "Are you sure you want to logout?",
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary
            ),
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
              context.read<AuthenticationProvider>().logout();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginScreen()
                  )
              );
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
                    l10n!.btn_yes,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ),
            )
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