import "package:borlago/base/presentation/widgets/app_logo.dart";
import "package:borlago/base/presentation/widgets/button.dart";
import "package:borlago/base/presentation/widgets/info_dialog.dart";
import "package:borlago/base/presentation/widgets/loader.dart";
import "package:borlago/base/presentation/widgets/text_input.dart";
import "package:borlago/base/utils/form_validators/email.dart";
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

  // errors
  String? _emailError;
  String? _resetCodeError;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _resetCodeController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final emailValidator = EmailValidator(context);
    final resetCodeValidator = TextValidator(context);

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
          resetCode: _resetCodeController.text
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: const Center(child: AppLogo()),
                  ),
                  const SizedBox(height: 15,),
                  _resetCodeSent ? Text(
                    l10n!.txt_reset_code,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ) : Container(),
                  const SizedBox(height: 25,),
                  _resetCodeSent ? TextInput(
                    controller: _resetCodeController,
                    placeholder: "######",
                    label: l10n!.lbl_reset_code,
                    prefixIcon: CupertinoIcons.lock_fill,
                    textInputType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    error: _resetCodeError,
                  ) : TextInput(
                    controller: _emailController,
                    placeholder: l10n!.plh_email,
                    label: l10n.lbl_email,
                    prefixIcon: CupertinoIcons.envelope_fill,
                    textInputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.done,
                    error: _emailError,
                  ),
                  const SizedBox(height: 25,),
                  _isLoading ? const Loader(size: 24): Button(
                    text: !_resetCodeSent ? l10n.btn_submit : l10n.btn_reset,
                    onTap: () {
                      if(!_resetCodeSent) {
                        setState(() {
                          _emailError = emailValidator(_emailController.text);
                        });
                        if(_emailError != null) {
                          return;
                        }
                      } else {
                        setState(() {
                          _resetCodeError = resetCodeValidator(_resetCodeController.text);
                        });
                        if(_resetCodeError != null) {
                          return;
                        }
                      }
                      FocusScope.of(context).unfocus();
                      makeRequest();
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
