import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/base/presentation/widgets/text_input.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/base/utils/form_validators/text.dart';
import 'package:borlago/feature_user/presentation/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BankCardForm extends StatefulWidget {
  const BankCardForm({super.key, required this.method});
  final PaymentType method;

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

  String? _nameOnCardError;
  String? _cardNumberError;
  String? _expiryDateError;
  String? _securityCodeError;
  String? _zipCodeError;

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
      bool success = false;

      setState(() {
        _isLoading = true;
      });

      // success = await _userViewModel.changePassword(
      //     currentPassword: _currentPasswordController.text,
      //     newPassword: _newPasswordController.text
      // );

      // if(success) {
      //   _currentPasswordController.clear();
      //   _newPasswordController.clear();
      //   _confirmNewPasswordController.clear();
      //   toast(message: l10n!.suc_password);
      // } else {
      //   toast(message: l10n!.err_wrong);
      // }

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
            inputAction: TextInputAction.next,
            placeholder: "####",
            label: l10n.lbl_zip_code,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_zipCodeFocusNode);
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
              text: l10n.btn_submit
          ),
        ],
      ),
    );
  }
}
