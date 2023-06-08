import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/base/presentation/widgets/text_input.dart';
import 'package:borlago/base/utils/form_validators/text.dart';
import 'package:borlago/base/utils/toast.dart';
import 'package:borlago/feature_user/domain/models/payment_method.dart';
import 'package:borlago/feature_user/domain/models/payment_type.dart';
import 'package:borlago/feature_user/presentation/screens/payment_methods_screen.dart';
import 'package:borlago/feature_user/presentation/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class BankCardForm extends StatefulWidget {
  const BankCardForm({
    super.key,
    required this.method,
    required this.type
  });

  final PaymentMethod? method;
  final PaymentType type;

  @override
  State<BankCardForm> createState() => _BankCardFormState();
}

class _BankCardFormState extends State<BankCardForm> {
  final UserViewModel _userViewModel = UserViewModel();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _nameOnCardController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _securityCodeController = TextEditingController();
  final _zipCodeControllerController = TextEditingController();

  final _nameOnCardFocusNode = FocusNode();
  final _cardNumberFocusNode = FocusNode();
  final _expiryDateFocusNode = FocusNode();
  final _securityCodeFocusNode = FocusNode();
  final _zipCodeFocusNode = FocusNode();

  final  _cardNumberInputFormatter = CreditCardNumberInputFormatter();
  final  _expiryDateFormatter = CreditCardExpirationDateFormatter();
  final _securityCodeInputFormatter = CreditCardCvcInputFormatter();

  String? _nameOnCardError;
  String? _cardNumberError;
  String? _expiryDateError;
  String? _securityCodeError;
  String? _zipCodeError;

  void navigateToPaymentMethodsScreen() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PaymentMethodsScreen())
    );
  }


  @override
  void initState() {
    if(widget.method != null) {
      _nameOnCardController.text = widget.method!.nameOnCard!;
      _cardNumberController.text = widget.method!.accountNumber;
      _expiryDateController.text = widget.method!.expiryDate!;
      _securityCodeController.text = widget.method!.securityCode!;
      _zipCodeControllerController.text = widget.method!.zipCode!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _nameOnCardController.dispose();
    _expiryDateController.dispose();
    _securityCodeController.dispose();
    _zipCodeControllerController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final nameOnCardValidator = TextValidator(context);
    final cardNumberValidator = TextValidator(context);
    final expiryDateValidator = TextValidator(context);
    final securityCodeValidator = TextValidator(context);
    final zipCodeValidator = TextValidator(context);

    void makeRequest() async {
      PaymentMethod? paymentMethod;

      setState(() {
        _isLoading = true;
      });

      if (widget.method != null) {
        paymentMethod = await _userViewModel.updatePaymentMethod(
          paymentMethodId: widget.method!.id,
          type: widget.type.type,
          name: widget.type.name,
          accountNumber: _cardNumberController.text,
          nameOnCard: _nameOnCardController.text,
          expiryDate: _expiryDateController.text,
          securityCode: _securityCodeController.text,
          zipCode: _zipCodeControllerController.text,
        );
      } else {
        paymentMethod = await _userViewModel.addPaymentMethod(
          type: widget.type.type,
          name: widget.type.name,
          accountNumber: _cardNumberController.text,
          nameOnCard: _nameOnCardController.text,
          expiryDate: _expiryDateController.text,
          securityCode: _securityCodeController.text,
          zipCode: _zipCodeControllerController.text,
        );
      }

      if(paymentMethod != null) {
        _cardNumberController.clear();
        _nameOnCardController.clear();
        _expiryDateController.clear();
        _securityCodeController.clear();
        _zipCodeControllerController.clear();
        navigateToPaymentMethodsScreen();
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
        children:[
          TextInput(
            controller: _nameOnCardController,
            textInputType: TextInputType.text,
            focusNode: _nameOnCardFocusNode,
            inputAction: TextInputAction.next,
            placeholder: l10n!.plh_name_on_card,
            label: l10n.lbl_name_on_card,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_cardNumberFocusNode);
            },
          ),
          const SizedBox(height: 15,),
          TextInput(
            controller: _cardNumberController,
            textInputType: TextInputType.number,
            focusNode: _cardNumberFocusNode,
            inputFormatters: [_cardNumberInputFormatter],
            inputAction: TextInputAction.next,
            placeholder: "#### #### #### ####",
            label: l10n.lbl_card_no,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_cardNumberFocusNode);
            },
          ),
          const SizedBox(height: 15,),
          Row(
            children: [
              Expanded(
                child: TextInput(
                  controller: _expiryDateController,
                  textInputType: TextInputType.datetime,
                  focusNode: _expiryDateFocusNode,
                  inputFormatters: [_expiryDateFormatter],
                  inputAction: TextInputAction.next,
                  placeholder: "MM/YY",
                  label: l10n.lbl_expiry_date,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_expiryDateFocusNode);
                  },
                ),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: TextInput(
                  controller: _securityCodeController,
                  textInputType: TextInputType.number,
                  focusNode: _securityCodeFocusNode,
                  inputFormatters: [_securityCodeInputFormatter],
                  inputAction: TextInputAction.next,
                  placeholder: "###",
                  label: l10n.lbl_security_code,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_securityCodeFocusNode);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 15,),
          TextInput(
            controller: _zipCodeControllerController,
            textInputType: TextInputType.number,
            focusNode: _zipCodeFocusNode,
            inputAction: TextInputAction.done,
            placeholder: "######",
            label: l10n.lbl_zip_code,
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
                  _nameOnCardError = nameOnCardValidator(_nameOnCardController.text);
                  _cardNumberError = cardNumberValidator(_cardNumberController.text);
                  _expiryDateError = expiryDateValidator(_expiryDateController.text);
                  _securityCodeError = securityCodeValidator(_securityCodeController.text);
                  _zipCodeError = zipCodeValidator(_zipCodeControllerController.text);
                });

                final errors = [
                  _nameOnCardError,
                  _cardNumberError,
                  _expiryDateError,
                  _securityCodeError,
                  _zipCodeError
                ];

                if(errors.every((error) => error == null)) {
                  FocusScope.of(context).unfocus();
                  makeRequest();
                }
              },
              text: widget.method != null ? l10n.btn_update : l10n.btn_submit
          ),
          widget.method != null ? const SizedBox(height: 80,) : const SizedBox(),
        ],
      ),
    );
  }
}
