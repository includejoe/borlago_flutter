import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/base/presentation/widgets/loader.dart';
import 'package:borlago/base/presentation/widgets/main_page_view.dart';
import 'package:borlago/base/presentation/widgets/password_input.dart';
import 'package:borlago/base/presentation/widgets/select_input.dart';
import 'package:borlago/base/presentation/widgets/text_input.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/base/utils/form_validators/password.dart';
import 'package:borlago/base/utils/form_validators/text.dart';
import 'package:borlago/base/utils/toast.dart';
import 'package:borlago/feature_authentication/presentation/widgets/bottom_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class RegisterFieldSet1 extends StatefulWidget {
  const RegisterFieldSet1({
    super.key,
    required this.phoneController,
    required this.genderController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.countryController,
    required this.previousFieldSet,
    required this.register,
  });
  final TextEditingController phoneController;
  final TextEditingController genderController;
  final TextEditingController passwordController;
  final TextEditingController countryController;
  final TextEditingController confirmPasswordController;
  final void Function() previousFieldSet;
  final Future<bool> Function() register;

  @override
  State<RegisterFieldSet1> createState() => _RegisterFieldSet1State();
}

class _RegisterFieldSet1State extends State<RegisterFieldSet1> {
  final _phoneFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool _isLoading = false;

  final  _phoneFormatter = PhoneInputFormatter();

  String? _phoneError;
  String? _genderError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void initState() {
    if(widget.countryController.text.isNotEmpty) {
      Constants.countryCodes.forEach((key, value) {
        if(key == widget.countryController.text) {
          widget.phoneController.text = value;
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final genderValidator = TextValidator(context);
    final phoneValidator = TextValidator(context);
    final passwordValidator = PasswordValidator(context, false);
    final confirmPasswordValidator = PasswordValidator(context, true);

    void navigateToMainScreen() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPageView()
        )
      );
    }

    void makeRequest() async {
      bool success = false;
      setState(() {
        _isLoading = true;
      });

      success = await widget.register();

      if(success) {
        navigateToMainScreen();
      } else {
        toast(message: l10n!.err_wrong);
      }

      setState(() {
        _isLoading = false;
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextInput(
          controller: widget.phoneController,
          textInputType: TextInputType.number,
          focusNode: _phoneFocusNode,
          inputFormatters: [_phoneFormatter],
          inputAction: TextInputAction.next,
          prefixIcon: CupertinoIcons.phone_fill,
          label: l10n!.lbl_phone,
          error: _phoneError,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_genderFocusNode);
          },
        ),
        const SizedBox(height: 15,),
        SelectInput(
          controller: widget.genderController,
          focusNode: _genderFocusNode,
          inputAction: TextInputAction.next,
          prefixIcon: CupertinoIcons.person_fill,
          label: l10n.lbl_gender,
          placeholder: l10n.plh_gender,
          dialogTitle: l10n.plh_gender,
          error: _genderError,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          options: [l10n.txt_male, l10n.txt_female, l10n.txt_other],
        ),
        const SizedBox(height: 15,),
        PasswordInput(
            controller: widget.passwordController,
            focusNode: _passwordFocusNode,
            inputAction: TextInputAction.next,
            error: _passwordError,
            label: l10n.lbl_password,
            placeholder: l10n.plh_password,
            showIcon: true,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
            },
        ),
        const SizedBox(height: 15,),
        PasswordInput(
            controller: widget.confirmPasswordController,
            focusNode: _confirmPasswordFocusNode,
            inputAction: TextInputAction.done,
            error: _confirmPasswordError,
            label: l10n.lbl_confirm_password,
            placeholder: l10n.plh_confirm_password,
            showIcon: true,
            onFieldSubmitted: (_) {
              FocusScope.of(context).unfocus();
            },
        ),
        const SizedBox(height: 15,),
        _isLoading ? const Loader(size: 24)  : Button(
            onTap: () {
              setState(() {
                _phoneError = phoneValidator(widget.countryController.text);
                _genderError = genderValidator(widget.genderController.text);
                _passwordError = passwordValidator(widget.passwordController.text, null);
                _confirmPasswordError = confirmPasswordValidator(
                    widget.confirmPasswordController.text,
                    widget.passwordController.text
                );
              });

              final errors = [
                _phoneError,
                _genderError,
                _passwordError,
                _confirmPasswordError
              ];

              if(errors.every((error) => error == null)) {
                FocusScope.of(context).unfocus();
                makeRequest();
              }
            },
            text: l10n.btn_register
        ),
        BottomAction(
          info: l10n.txt_mistakes,
          btnText: l10n.btn_back,
          action: widget.previousFieldSet,
        )
      ],
    );
  }
}
