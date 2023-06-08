import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/feature_user/presentation/screens/payment_method_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<dynamic> paymentMethodsDialog({
  required BuildContext context,
}) {
  final theme = Theme.of(context);
  final l10n = AppLocalizations.of(context);
  final user = getIt.get<AuthenticationProvider>().user;
  List<PaymentType> paymentMethods = [];

  Constants.paymentMethods.forEach((key, value) {
    if(key == user!.country) {
      paymentMethods = value;
    }
  });

  return showDialog(
    context: context,
    builder: (context) =>  SimpleDialog(
      title: Center(
        child: Text(
            l10n!.plh_payment,
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
        for (var method in paymentMethods)
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentMethodDetailScreen(
                        method: method,
                      )
                  )
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      method.logo,
                      height: 35,
                      width: 35,
                      fit: BoxFit.contain,
                    ),
                  )
                ),
                Text(method.name, style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          )
      ]
  ));
}