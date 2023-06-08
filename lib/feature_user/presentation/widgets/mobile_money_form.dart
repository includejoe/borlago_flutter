import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/base/presentation/widgets/text_input.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/base/utils/form_validators/text.dart';
import 'package:borlago/base/utils/toast.dart';
import 'package:borlago/feature_user/domain/models/payment_method.dart';
import 'package:borlago/feature_user/presentation/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MobileMoneyForm extends StatefulWidget {
  const MobileMoneyForm({
    super.key,
    this.method,
    required this.type
  });

  final PaymentMethod? method;
  final PaymentType type;

  @override
  State<MobileMoneyForm> createState() => _MobileMoneyFormState();
}


class _MobileMoneyFormState extends State<MobileMoneyForm> {
  final UserViewModel _userViewModel = UserViewModel();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _momoNumberController = TextEditingController();
  final _momoNumberFocusNode = FocusNode();
  String? _momoNumberError;

  void popContext() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    if(widget.method != null) {
      _momoNumberController.text = widget.method!.accountNumber;
    }
    super.initState();
  }

  @override
  void dispose() {
    _momoNumberController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final numberValidator = TextValidator(context);

    void makeRequest() async {
      PaymentMethod? paymentMethod;

      setState(() {
        _isLoading = true;
      });

      paymentMethod = await _userViewModel.addPaymentMethod(
        type: widget.type.type,
        name: widget.type.name,
        accountNumber: _momoNumberController.text,
      );

      if(paymentMethod != null) {
        _momoNumberController.clear();
        popContext();
      } else {
        toast(message: l10n!.err_wrong);
      }

      setState(() {
        _isLoading = false;
      });
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextInput(
            controller: _momoNumberController,
            textInputType: TextInputType.number,
            focusNode: _momoNumberFocusNode,
            inputAction: TextInputAction.done,
            placeholder: "##########",
            label: l10n!.lbl_mobile_no,
            onFieldSubmitted: (_) {
              FocusScope.of(context).dispose();
            },
          ),
          const SizedBox(height: 25,),
          _isLoading ? SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
                strokeWidth: 3,
                color: theme.colorScheme.primary
            ),
          ) : Button(
              onTap: () {
                setState(() {
                  _momoNumberError = numberValidator(_momoNumberController.text);
                });

                if(_momoNumberError == null) {
                  FocusScope.of(context).unfocus();
                  makeRequest();
                }
              },
              text: l10n.btn_submit
          ),
        ],
      )
    );
  }
}
