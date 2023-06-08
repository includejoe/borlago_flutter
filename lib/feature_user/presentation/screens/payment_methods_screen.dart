import 'package:borlago/base/presentation/widgets/float_action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          title: Text(
            l10n!.lbl_payment_method,
            style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.onPrimary
            ),
          ),
        ),
        body: Center(
          child: Text(
            "PAYMENT METHODS SCREEN",
            style: theme.textTheme.headlineMedium,
          ),
        ),
        floatingActionButton: FloatActionButton(
            onPressed: () {},
            icon: CupertinoIcons.add
        )
    );
  }
}
