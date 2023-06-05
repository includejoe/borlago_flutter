import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/base/presentation/widgets/main_page_view.dart';
import 'package:borlago/base/presentation/widgets/password_input.dart';
import 'package:borlago/base/presentation/widgets/select_input.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/base/utils/form_validators/password.dart';
import 'package:borlago/base/utils/form_validators/text.dart';
import 'package:borlago/base/utils/toast.dart';
import 'package:borlago/feature_authentication/presentation/screens/authenticated_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterFieldSet1 extends StatefulWidget {
  const RegisterFieldSet1({
    super.key,
    required this.genderController,
    required this.countryController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.previousFieldSet,
    required this.register,
  });

  final TextEditingController genderController;
  final TextEditingController countryController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final void Function() previousFieldSet;
  final Future<bool> Function() register;

  @override
  State<RegisterFieldSet1> createState() => _RegisterFieldSet1State();
}

class _RegisterFieldSet1State extends State<RegisterFieldSet1> {
  final _genderFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  bool _isLoading = false;

  String? _genderError;
  String? _countryError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final genderValidator = TextValidator(context);
    final countryValidator = TextValidator(context);
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
        SelectInput(
          controller: widget.genderController,
          focusNode: _genderFocusNode,
          inputAction: TextInputAction.next,
          prefixIcon: CupertinoIcons.person_fill,
          placeholder: l10n!.plh_gender,
          dialogTitle: l10n.lbl_gender,
          error: _genderError,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_countryFocusNode);
          },
          options: [l10n.male, l10n.female, l10n.other],
        ),
        const SizedBox(height: 15,),
        SelectInput(
          controller: widget.countryController,
          focusNode: _countryFocusNode,
          inputAction: TextInputAction.next,
          prefixIcon: CupertinoIcons.globe,
          placeholder: l10n.plh_country,
          dialogTitle: l10n.lbl_country,
          error: _countryError,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          options: Constants.countries,
        ),
        const SizedBox(height: 15,),
        PasswordInput(
            controller: widget.passwordController,
            focusNode: _passwordFocusNode,
            inputAction: TextInputAction.next,
            error: _passwordError,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
            },
            placeholder: l10n.plh_password
        ),
        const SizedBox(height: 15,),
        PasswordInput(
            controller: widget.confirmPasswordController,
            focusNode: _confirmPasswordFocusNode,
            inputAction: TextInputAction.done,
            error: _confirmPasswordError,
            onFieldSubmitted: (_) {
              FocusScope.of(context).unfocus();
            },
            placeholder: l10n.plh_confirm_password
        ),
        const SizedBox(height: 15,),
        _isLoading ? SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: theme.colorScheme.primary
          ),
        )  : Button(
            onTap: () {
              setState(() {
                _genderError = genderValidator(widget.genderController.text);
                _countryError = countryValidator(widget.countryController.text);
                _passwordError = passwordValidator(widget.passwordController.text, null);
                _confirmPasswordError = confirmPasswordValidator(
                    widget.confirmPasswordController.text,
                    widget.passwordController.text
                );
              });

              final errors = [
                _genderError,
                _countryError,
                _passwordError,
                _confirmPasswordError
              ];

              if(errors.every((error) => error == null)) {
                FocusScope.of(context).unfocus();
                makeRequest();
              }
            },
            text: l10n.btn_register
        )
      ],
    );
  }
}
