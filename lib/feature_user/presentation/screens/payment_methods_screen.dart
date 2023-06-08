import 'package:borlago/base/presentation/widgets/float_action_button.dart';
import 'package:borlago/feature_user/domain/models/payment_method.dart';
import 'package:borlago/feature_user/presentation/screens/settings_screen.dart';
import 'package:borlago/feature_user/presentation/user_view_model.dart';
import 'package:borlago/feature_user/presentation/widgets/payment_method_item.dart';
import 'package:borlago/feature_user/presentation/widgets/payment_methods_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final UserViewModel _userViewModel = UserViewModel();
  List<PaymentMethod?> _paymentMethods = [];

  @override
  void initState() {
    _userViewModel.getPaymentMethods().then((methods) {
      setState(() {
        _paymentMethods = methods!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final List<PaymentMethodItem> paymentMethodItems = _paymentMethods.map((paymentMethod) {
      return PaymentMethodItem(
        method: paymentMethod!,
      );
    }).toList();

    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SettingsScreen())
              );
            },
          ),
          title: Text(
            l10n!.lbl_payment_method,
            style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.onPrimary
            ),
          ),
        ),
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: paymentMethodItems.length,
            itemBuilder: (context, index) {
              return paymentMethodItems[index];
            }
        ),
        floatingActionButton: FloatActionButton(
            onPressed: () {
              paymentMethodsDialog(context: context);
            },
            icon: CupertinoIcons.add
        )
    );
  }
}
