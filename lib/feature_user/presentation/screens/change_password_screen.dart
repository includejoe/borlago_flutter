import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/base/presentation/widgets/password_input.dart';
import 'package:borlago/base/utils/form_validators/password.dart';
import 'package:borlago/base/utils/toast.dart';
import 'package:borlago/feature_user/presentation/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final UserViewModel _userViewModel = UserViewModel();
  bool _isLoading = false;

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  final _currentPasswordFocusNode = FocusNode();
  final _newPasswordFocusNode = FocusNode();
  final _confirmNewPasswordFocusNode = FocusNode();

  String? _currentPasswordError;
  String? _newPasswordError;
  String? _confirmNewPasswordError;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final currentPasswordValidator = PasswordValidator(context, false);
    final newPasswordValidator = PasswordValidator(context, false);
    final confirmNewPasswordValidator = PasswordValidator(context, true);


    void makeRequest() async {
      bool success = false;

      setState(() {
        _isLoading = true;
      });

      success = await _userViewModel.changePassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text
      );

      if(success) {
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmNewPasswordController.clear();
        toast(message: l10n!.suc_password);
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
          l10n!.lbl_change_password,
          style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PasswordInput(
                  controller: _currentPasswordController,
                  focusNode: _currentPasswordFocusNode,
                  inputAction: TextInputAction.next,
                  placeholder: l10n.plh_current_password,
                  error: _currentPasswordError,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_newPasswordFocusNode);
                  },
                  label: l10n.lbl_current_password
                ),
                const SizedBox(height: 15,),
                PasswordInput(
                    controller: _newPasswordController,
                    focusNode: _newPasswordFocusNode,
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
                    inputAction: TextInputAction.next,
                    placeholder: l10n.plh_confirm_new_password,
                    error: _confirmNewPasswordError,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_confirmNewPasswordFocusNode);
                    },
                    label: l10n.lbl_confirm_new_password
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
                        _currentPasswordError = currentPasswordValidator(
                          _currentPasswordController.text,
                          null
                        );
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
                        _currentPasswordError,
                        _newPasswordError,
                        _confirmNewPasswordError
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
          ),
        ),
      ),
    );
  }
}
