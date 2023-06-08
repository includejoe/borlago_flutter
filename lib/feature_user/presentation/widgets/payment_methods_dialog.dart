import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/feature_user/domain/models/payment_type.dart';
import 'package:borlago/feature_user/presentation/screens/payment_method_detail_screen.dart';
import 'package:borlago/feature_user/presentation/widgets/payment_method_logo.dart';
import 'package:flutter/material.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<dynamic> paymentMethodsDialog({
  required BuildContext context,
}) {
  final theme = Theme.of(context);
  final l10n = AppLocalizations.of(context);
  final user = getIt.get<AuthenticationProvider>().user;
  List<PaymentType> paymentTypes = [];

  Constants.paymentTypes.forEach((key, value) {
    if(key == user!.country) {
      paymentTypes = value;
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
        for (var type in paymentTypes)
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentMethodDetailScreen(
                      type: type,
                    )
                  )
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PaymentMethodLogo(logoUrl: type.logo, size: 35),
                Text(type.name, style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          )
      ]
  ));
}