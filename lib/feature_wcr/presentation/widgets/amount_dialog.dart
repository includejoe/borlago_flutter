import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/base/presentation/widgets/dialog_button.dart';
import 'package:borlago/base/presentation/widgets/main_page_view.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:borlago/feature_wcr/domain/models/wcr.dart';
import 'package:borlago/feature_wcr/presentation/screens/make_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<dynamic> amountDialog({
  required BuildContext context,
  required WCR wcr,
}) {
  final theme = Theme.of(context);
  final l10n = AppLocalizations.of(context);
  final currency = getIt.get<AuthenticationProvider>().currency;

  return showDialog(
      context: context,
      builder: (context) =>  SimpleDialog(
        contentPadding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: theme.colorScheme.surface,
        children: [
          Text(
            "${l10n!.txt_amount} $currency ${wcr.price}",
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8,),
          Column(
            children: [
              SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MakePaymentScreen(
                            wcr: wcr,
                            justCreated: true,
                          )
                      )
                    );
                  },
                child: DialogButton(btnText: l10n.btn_make_payment),
              ),
              SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => const MainPageView()
                    ));
                  },
                  child: Center(
                    child: Text(
                      l10n.btn_cancel,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),),
                  )
              ),
            ],
          )
        ],
      )
  );
}