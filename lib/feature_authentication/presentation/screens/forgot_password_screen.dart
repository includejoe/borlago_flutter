import "package:borlago/base/presentation/widgets/app_logo.dart";
import "package:borlago/base/presentation/widgets/button.dart";
import "package:borlago/base/presentation/widgets/info_dialog.dart";
import "package:borlago/base/presentation/widgets/loader.dart";
import "package:borlago/base/presentation/widgets/password_input.dart";
import "package:borlago/base/presentation/widgets/text_input.dart";
import "package:borlago/base/utils/form_validators/email.dart";
import "package:borlago/base/utils/form_validators/password.dart";
import "package:borlago/base/utils/form_validators/text.dart";
import "package:borlago/base/utils/toast.dart";
import "package:borlago/feature_authentication/presentation/auth_view_model.dart";
import "package:borlago/feature_authentication/presentation/widgets/bottom_action.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final AuthenticationViewModel _authViewModel = AuthenticationViewModel();
  final _formKey = GlobalKey<FormState>();
  bool _resetCodeSent = false;
  bool _isLoading = false;

  // controllers
  final _emailController = TextEditingController();
  final _resetCodeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  // focus nodes
  final _newPasswordFocusNode = FocusNode();
  final _confirmNewPasswordFocusNode = FocusNode();

  // errors
  String? _emailError;
  String? _resetCodeError;
  String? _newPasswordError;
  String? _confirmNewPasswordError;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _resetCodeController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final emailValidator = EmailValidator(context);
    final resetCodeValidator = TextValidator(context);
    final newPasswordValidator = PasswordValidator(context, false);
    final confirmNewPasswordValidator = PasswordValidator(context, true);

    void showInfoDialog() {
      infoDialog(
        context: context,
        info: l10n!.suc_password_reset,
        okAction: () {
          Navigator.of(context).pop();
        }
      );
    }

    void makeRequest() async {
      bool forgotPasswordSuccess = false;
      bool resetPasswordSuccess = false;
      setState(() {
        _isLoading = true;
      });

      if(!_resetCodeSent) {
        forgotPasswordSuccess = await _authViewModel.forgotPassword(
          email: _emailController.text
        );
      } else {
        resetPasswordSuccess = await _authViewModel.resetPassword(
          email: _emailController.text,
          resetCode: _resetCodeController.text,
          newPassword: _newPasswordController.text
        );
      }

      if(forgotPasswordSuccess) {
        setState(() {
          _resetCodeSent = true;
        });
      }

      if(resetPasswordSuccess) {
        showInfoDialog();
      }

      if(!forgotPasswordSuccess && !resetPasswordSuccess) {
        toast(message: l10n!.err_wrong);
      }

      setState(() {
        _isLoading = false;
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: !_resetCodeSent ? MediaQuery.of(context).size.height * 0.22 :
                    MediaQuery.of(context).size.height * 0.12,
                  ),
                  SizedBox(
                    height: !_resetCodeSent ? MediaQuery.of(context).size.height * 0.18 :
                    MediaQuery.of(context).size.height * 0.15,
                    child: const Center(child: AppLogo()),
                  ),
                  const SizedBox(height: 15,),
                  Text(
                    !_resetCodeSent ? l10n!.txt_forgot_password :
                    l10n!.txt_reset_code,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25,),
                  !_resetCodeSent ? TextInput(
                    controller: _emailController,
                    placeholder: l10n!.plh_email,
                    label: l10n.lbl_email,
                    prefixIcon: CupertinoIcons.envelope_fill,
                    textInputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.done,
                    error: _emailError,
                  ): Column(
                    children: [
                      TextInput(
                        controller: _resetCodeController,
                        placeholder: l10n!.plh_reset_code,
                        label: l10n.lbl_reset_code,
                        prefixIcon: CupertinoIcons.lock_fill,
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        error: _resetCodeError,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_newPasswordFocusNode);
                        },
                      ),
                      const SizedBox(height: 15,),
                      PasswordInput(
                          controller: _newPasswordController,
                          focusNode: _newPasswordFocusNode,
                          showIcon: true,
                          inputAction: TextInputAction.next,
                          placeholder: l10n.plh_new_password,
                          error: _newPasswordError,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_confirmNewPasswordFocusNode);
                          },
                          label: l10n.lbl_new_password
                      ),
                      const SizedBox(height: 15,),
                      PasswordInput(
                          controller: _confirmNewPasswordController,
                          focusNode: _confirmNewPasswordFocusNode,
                          showIcon: true,
                          inputAction: TextInputAction.done,
                          placeholder: l10n.plh_confirm_new_password,
                          error: _confirmNewPasswordError,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).unfocus();
                          },
                          label: l10n.lbl_confirm_new_password
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  _isLoading ? const Loader(size: 24): Button(
                    text: !_resetCodeSent ? l10n.btn_submit : l10n.btn_reset,
                    onTap: () {
                      if(!_resetCodeSent) {
                        setState(() {
                          _emailError = emailValidator(_emailController.text);
                        });
                        if(_emailError == null) {
                          FocusScope.of(context).unfocus();
                          makeRequest();
                        }
                      } else {
                        setState(() {
                          _resetCodeError = resetCodeValidator(_resetCodeController.text);
                          _newPasswordError = newPasswordValidator(
                              _newPasswordController.text,
                              null
                          );
                          _confirmNewPasswordError = confirmNewPasswordValidator(
                            _newPasswordController.text,
                            _confirmNewPasswordController.text,
                          );
                        });

                        final errors = [
                          _resetCodeError,
                          _newPasswordError,
                          _confirmNewPasswordError
                        ];

                        if(errors.every((error) => error == null)) {
                          FocusScope.of(context).unfocus();
                          makeRequest();
                        }
                      }

                    },
                  ),
                  BottomAction(
                    btnText: l10n.btn_login,
                    action: () {
                      Navigator.of(context).pop();
                    },
                    info: l10n.txt_yes_account,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
