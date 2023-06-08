import 'package:borlago/base/presentation/widgets/confirmationDialog.dart';
import 'package:borlago/base/presentation/widgets/float_action_button.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/base/utils/toast.dart';
import 'package:borlago/feature_user/domain/models/payment_method.dart';
import 'package:borlago/feature_user/presentation/screens/payment_methods_screen.dart';
import 'package:borlago/feature_user/presentation/user_view_model.dart';
import 'package:borlago/feature_user/presentation/widgets/bank_card_form.dart';
import 'package:borlago/feature_user/presentation/widgets/mobile_money_form.dart';
import 'package:borlago/feature_user/presentation/widgets/payment_method_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentMethodDetailScreen extends StatefulWidget {
  const PaymentMethodDetailScreen({
    super.key,
    required this.type,
    this.method
  });
  final PaymentType type;
  final PaymentMethod? method;

  @override
  State<PaymentMethodDetailScreen> createState() => _PaymentMethodDetailScreenState();
}

class _PaymentMethodDetailScreenState extends State<PaymentMethodDetailScreen> {
  final UserViewModel _userViewModel = UserViewModel();
  bool _isLoading = false;

  void navigateToPaymentMethodsScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const PaymentMethodsScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    void deletePaymentMethod() async {
      bool success = false;

      setState(() {
        _isLoading = true;
      });

      success = await _userViewModel.deletePaymentMethod(
        paymentMethodId: widget.method!.id
      );

      if(success) {
        navigateToPaymentMethodsScreen();
      } else {
        toast(message: l10n!.err_wrong);
      }

      setState(() {
        _isLoading = false;
      });
    }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              PaymentMethodLogo(logoUrl: widget.type.logo, size: 100),
              const SizedBox(height: 15,),
              Text(
                widget.type.name,
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 60,),
              widget.type.type == "Mobile Money" ?
                MobileMoneyForm(method: widget.method, type: widget.type,) :
                BankCardForm(method: widget.method, type: widget.type,)
            ],
          ),
        ),
      ),
      floatingActionButton: widget.method != null ? FloatActionButton(
        onPressed: () {
          confirmationDialog(
            context: context,
            title: l10n.txt_confirm_delete,
            yesAction: () {
              deletePaymentMethod();
            }
          );
        },
        icon: Icons.delete,
      ) : Container(),
    );
  }
}
