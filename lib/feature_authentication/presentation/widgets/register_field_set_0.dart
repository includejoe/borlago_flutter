import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/base/presentation/widgets/text_input.dart';
import 'package:borlago/base/utils/form_validators/email.dart';
import 'package:borlago/base/utils/form_validators/text.dart';
import 'package:borlago/feature_authentication/presentation/screens/login_screen.dart';
import 'package:borlago/feature_authentication/presentation/widgets/bottom_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterFieldSet0 extends StatefulWidget {
  const RegisterFieldSet0({
    super.key,
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.nextFieldSet
  });

  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final void Function()  nextFieldSet;

  @override
  State<RegisterFieldSet0> createState() => _RegisterFieldSet0State();
}

class _RegisterFieldSet0State extends State<RegisterFieldSet0> {
  final _emailFocusNode = FocusNode();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  String? _emailError;
  String? _firstNameError;
  String? _lastNameError;
  String? _phoneError;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final emailValidator = EmailValidator(context);
    final firstNameValidator = TextValidator(context);
    final lastNameValidator = TextValidator(context);
    final phoneValidator = TextValidator(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextInput(
          controller: widget.emailController,
          textInputType: TextInputType.emailAddress,
          focusNode: _emailFocusNode,
          inputAction: TextInputAction.next,
          prefixIcon: CupertinoIcons.envelope_fill,
          placeholder: l10n!.lbl_email,
          error: _emailError,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_firstNameFocusNode);
          },
        ),
        const SizedBox(height: 15,),
        TextInput(
          controller: widget.firstNameController,
          textInputType: TextInputType.text,
          focusNode: _firstNameFocusNode,
          inputAction: TextInputAction.next,
          prefixIcon: CupertinoIcons.person_fill,
          placeholder: l10n.lbl_first_name,
          error: _firstNameError,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_lastNameFocusNode);
          },
        ),
        const SizedBox(height: 15,),
        TextInput(
          controller: widget.lastNameController,
          textInputType: TextInputType.text,
          focusNode: _lastNameFocusNode,
          inputAction: TextInputAction.next,
          prefixIcon: CupertinoIcons.person_fill,
          placeholder: l10n.lbl_last_name,
          error: _lastNameError,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_phoneFocusNode);
          },
        ),
        const SizedBox(height: 15,),
        TextInput(
          controller: widget.phoneController,
          textInputType: TextInputType.text,
          focusNode: _phoneFocusNode,
          inputAction: TextInputAction.next,
          prefixIcon: CupertinoIcons.phone_fill,
          placeholder: l10n.lbl_phone,
          error: _phoneError,
          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
          },
        ),
        const SizedBox(height: 15,),
        Button(
          onTap: () {
            setState(() {
              _emailError = emailValidator(widget.emailController.text);
              _firstNameError = firstNameValidator(widget.firstNameController.text);
              _lastNameError = lastNameValidator(widget.lastNameController.text);
              _phoneError = phoneValidator(widget.phoneController.text);
            });

            final errors = [
              _emailError,
              _firstNameError,
              _lastNameError,
              _phoneError,
            ];

            if(errors.every((error) => error == null)) {
              FocusScope.of(context).unfocus();
              widget.nextFieldSet();
            }
          },
          text: l10n.btn_next
        ),
        BottomAction(
          btnText: l10n.btn_login,
          action: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen()
              )
            );
          },
          info: l10n.txt_yes_account,
        )
      ]
    );
  }
}
