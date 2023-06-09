import 'package:borlago/base/presentation/widgets/float_action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MakePaymentScreen extends StatefulWidget {
  const MakePaymentScreen({super.key, required this.amountToPay});
  final double amountToPay;

  @override
  State<MakePaymentScreen> createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          l10n!.lbl_make_payment,
          style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: Center(
        child: Text(
          "PAYMENT SCREEN",
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
