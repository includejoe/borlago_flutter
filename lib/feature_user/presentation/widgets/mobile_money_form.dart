import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/base/presentation/widgets/text_input.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/base/utils/form_validators/text.dart';
import 'package:borlago/feature_user/presentation/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MobileMoneyForm extends StatefulWidget {
  const MobileMoneyForm({super.key, required this.method});
  final PaymentType method;

  @override
  State<MobileMoneyForm> createState() => _MobileMoneyFormState();
}

class _MobileMoneyFormState extends State<MobileMoneyForm> {
  final UserViewModel _userViewModel = UserViewModel();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _numberController = TextEditingController();
  final _numberFocusNode = FocusNode();
  String? _numberError;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final numberValidator = TextValidator(context);

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
        children: [
          TextInput(
            controller: _numberController,
            textInputType: TextInputType.number,
            focusNode: _numberFocusNode,
            inputAction: TextInputAction.next,
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
                  _numberError = numberValidator(_numberController.text);
                });

                if(_numberError == null) {
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
