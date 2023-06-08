import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/base/utils/form_validators/text.dart';
import 'package:borlago/feature_user/presentation/user_view_model.dart';
import 'package:borlago/feature_user/presentation/widgets/bank_card_form.dart';
import 'package:borlago/feature_user/presentation/widgets/mobile_money_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentMethodDetailScreen extends StatelessWidget {
  const PaymentMethodDetailScreen({super.key, required this.method});
  final PaymentType method;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          title: Text(
            l10n!.lbl_add_payment_method,
            style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.onPrimary
            ),
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipOval(
                  child: Image.asset(
                    method.logo,
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                )
            ),
            const SizedBox(height: 15,),
            Text(
              method.name,
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 60,),
            method.type == "Mobile Money" ?
              MobileMoneyForm(method: method) :
              BankCardForm(method: method,)
          ],
        ),
      ),

    );
  }
}
