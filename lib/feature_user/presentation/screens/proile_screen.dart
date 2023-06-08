import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/base/presentation/widgets/select_input.dart';
import 'package:borlago/base/presentation/widgets/text_input.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/base/utils/form_validators/email.dart';
import 'package:borlago/base/utils/form_validators/text.dart';
import 'package:borlago/base/utils/toast.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:borlago/feature_user/domain/models/user.dart';
import 'package:borlago/feature_user/presentation/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserViewModel _userViewModel = UserViewModel();
  late final AuthenticationProvider _authProvider;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _genderController = TextEditingController();
  final _countryController = TextEditingController();
  final _phoneController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();

  final _phoneFormatter = PhoneInputFormatter();

  String? _firstNameError;
  String? _lastNameError;
  String? _phoneError;
  String? _genderError;
  String? _countryError;

  @override
  void initState() {
    _authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    _authProvider.init();
    final user = _authProvider.user!;

    _emailController.text = user.email;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _phoneController.text = user.phone;
    _genderController.text = user.gender;
    _countryController.text = user.country;
    super.initState();
  }


  @override void dispose() {
    super.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _countryController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final firstNameValidator = TextValidator(context);
    final lastNameValidator = TextValidator(context);
    final phoneValidator = TextValidator(context);
    final genderValidator = TextValidator(context);
    final countryValidator = TextValidator(context);



    void makeRequest() async {
      User? updatedUser;
      setState(() {
        _isLoading = true;
      });

      updatedUser = await _userViewModel.updateUser(
        email: _authProvider.user!.email,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phone: _phoneController.text,
        gender: _genderController.text,
        country: _countryController.text,
      );

      if (updatedUser != null) {
        _firstNameController.text = updatedUser.firstName;
        _lastNameController.text = updatedUser.lastName;
        _phoneController.text = updatedUser.phone;
        _genderController.text = updatedUser.gender;
        _countryController.text = updatedUser.country;
        _authProvider.user = updatedUser;
        toast(message: l10n!.suc_update);
      } else {
        _emailController.text = _authProvider.user!.email;
        _firstNameController.text = _authProvider.user!.firstName;
        _lastNameController.text = _authProvider.user!.lastName;
        _phoneController.text = _authProvider.user!.phone;
        _genderController.text = _authProvider.user!.gender;
        _countryController.text = _authProvider.user!.country;
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
          l10n!.lbl_profile,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  CupertinoIcons.person_crop_circle_fill,
                  size: 220,
                  color: theme.colorScheme.onBackground,
                ),
                const SizedBox(height: 15,),
                TextInput(
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  focusNode: _emailFocusNode,
                  inputAction: TextInputAction.next,
                  prefixIcon: CupertinoIcons.envelope_fill,
                  enabled: false,
                  label: l10n.lbl_email,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_firstNameFocusNode);
                  },
                ),
                const SizedBox(height: 15,),
                TextInput(
                  controller: _firstNameController,
                  textInputType: TextInputType.text,
                  focusNode: _firstNameFocusNode,
                  inputAction: TextInputAction.next,
                  prefixIcon: CupertinoIcons.person_fill,
                  label: l10n.lbl_first_name,
                  error: _firstNameError,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_lastNameFocusNode);
                  },
                ),
                const SizedBox(height: 15,),
                TextInput(
                  controller: _lastNameController,
                  textInputType: TextInputType.text,
                  focusNode: _lastNameFocusNode,
                  inputAction: TextInputAction.next,
                  prefixIcon: CupertinoIcons.person_fill,
                  label: l10n.lbl_last_name,
                  error: _lastNameError,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_phoneFocusNode);
                  },
                ),
                const SizedBox(height: 15,),
                TextInput(
                  controller: _phoneController,
                  textInputType: TextInputType.text,
                  focusNode: _phoneFocusNode,
                  inputFormatters: [_phoneFormatter],
                  inputAction: TextInputAction.next,
                  prefixIcon: CupertinoIcons.phone_fill,
                  label: l10n.lbl_phone,
                  error: _phoneError,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_genderFocusNode);
                  },
                ),
                const SizedBox(height: 15,),
                SelectInput(
                  controller: _genderController,
                  focusNode: _genderFocusNode,
                  inputAction: TextInputAction.next,
                  prefixIcon: CupertinoIcons.person_fill,
                  label: l10n.lbl_gender,
                  dialogTitle: l10n.plh_gender,
                  error: _genderError,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_countryFocusNode);
                  },
                  options: [l10n.txt_male, l10n.txt_female, l10n.txt_other],
                ),
                const SizedBox(height: 15,),
                SelectInput(
                  controller: _countryController,
                  focusNode: _countryFocusNode,
                  inputAction: TextInputAction.next,
                  prefixIcon: CupertinoIcons.globe,
                  label: l10n.lbl_country,
                  dialogTitle: l10n.plh_country,
                  error: _countryError,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).dispose();
                  },
                  options: Constants.countries,
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
                          _firstNameError = firstNameValidator(_firstNameController.text);
                          _lastNameError = lastNameValidator(_lastNameController.text);
                          _phoneError = phoneValidator(_phoneController.text);
                          _genderError = genderValidator(_genderController.text);
                          _countryError = countryValidator(_countryController.text);
                        });

                        final errors = [
                          _firstNameError,
                          _lastNameError,
                          _phoneError,
                          _genderError,
                          _countryError,
                        ];

                        if(errors.every((error) => error == null)) {
                          FocusScope.of(context).unfocus();
                          makeRequest();
                        }
                      },
                      text: l10n.btn_save
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
