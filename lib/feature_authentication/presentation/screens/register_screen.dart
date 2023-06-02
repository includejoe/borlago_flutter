import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/base/presentation/widgets/app_logo.dart';
import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/base/utils/form_validators/email.dart';
import 'package:borlago/base/utils/form_validators/password.dart';
import 'package:borlago/base/utils/form_validators/text.dart';
import 'package:borlago/feature_authentication/presentation/auth_view_model.dart';
import 'package:borlago/feature_authentication/presentation/screens/login_screen.dart';
import 'package:borlago/feature_authentication/presentation/widgets/password_input.dart';
import 'package:borlago/feature_authentication/presentation/widgets/select_input.dart';
import 'package:borlago/feature_authentication/presentation/widgets/text_input.dart';
import 'package:borlago/base/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthenticationViewModel authViewModel = getIt<AuthenticationViewModel>();

  // controllers
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _genderController = TextEditingController();
  final _countryController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // focus nodes
  final _emailFocusNode = FocusNode();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  // errors
  String? _emailError;
  String? _firstNameError;
  String? _lastNameError;
  String? _genderError;
  String? _countryError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override void dispose() {
    super.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _countryController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    void navigateToMainScreen() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const MainScreen()
          )
      );
    }

    void makeRegisterRequest() async {
      setState(() {
        _isLoading = true;
      });

      bool success = await authViewModel.register(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        gender: _genderController.text,
        country: _countryController.text,
        phone: _phoneController.text,
        password: _passwordController.text
      );

      setState(() {
        _isLoading = false;
      });

      if(success) {
        _emailController.clear();
        _firstNameController.clear();
        _lastNameController.clear();
        _genderController.clear();
        _countryController.clear();
        _phoneController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
        navigateToMainScreen();
      } else {
        Fluttertoast.showToast(
          msg: l10n!.err_wrong,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.grey.shade900,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }

    // validators
    final emailValidator = EmailValidator(context);
    final firstNameValidator = TextValidator(context);
    final lastNameValidator = TextValidator(context);
    final genderValidator = TextValidator(context);
    final countryValidator = TextValidator(context);
    final phoneValidator = TextValidator(context);
    final passwordValidator = PasswordValidator(context, false);
    final confirmPasswordValidator = PasswordValidator(context, true);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.28,
                    child: const Center(child: AppLogo()),
                  ),
                  TextInput(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    focusNode: _emailFocusNode,
                    inputAction: TextInputAction.next,
                    prefixIcon: Icons.email,
                    placeholder: l10n!.plh_email,
                    error: _emailError,
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
                    prefixIcon: Icons.person,
                    placeholder: l10n.plh_first_name,
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
                    prefixIcon: Icons.person,
                    placeholder: l10n.plh_last_name,
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
                    inputAction: TextInputAction.next,
                    prefixIcon: Icons.phone,
                    placeholder: l10n.plh_phone,
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
                    prefixIcon: Icons.person,
                    placeholder: l10n.plh_gender,
                    label: l10n.lbl_gender,
                    error: _genderError,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_countryFocusNode);
                    },
                    options: [l10n.male, l10n.female, l10n.other],
                  ),
                  const SizedBox(height: 15,),
                  SelectInput(
                    controller: _countryController,
                    focusNode: _countryFocusNode,
                    inputAction: TextInputAction.next,
                    prefixIcon: Icons.public,
                    placeholder: l10n.plh_country,
                    label: l10n.lbl_country,
                    error: _countryError,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    options: [
                      l10n.country_bj,
                      l10n.country_bf,
                      l10n.country_ci,
                      l10n.country_cv,
                      l10n.country_gh,
                      l10n.country_gm,
                      l10n.country_gn,
                      l10n.country_lr,
                      l10n.country_ml,
                      l10n.country_mr,
                      l10n.country_ne,
                      l10n.country_ng,
                      l10n.country_sn,
                      l10n.country_sl,
                      l10n.country_tg,
                    ],
                  ),
                  const SizedBox(height: 15,),
                  PasswordInput(
                      controller: _passwordController,
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
                      controller: _confirmPasswordController,
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
                  ) : Button(
                      onTap: () {
                        setState(() {
                          _emailError = emailValidator(_emailController.text);
                          _firstNameError = firstNameValidator(_firstNameController.text);
                          _lastNameError = lastNameValidator(_lastNameController.text);
                          _genderError = genderValidator(_genderController.text);
                          _phoneError = phoneValidator(_phoneController.text);
                          _countryError = countryValidator(_countryController.text);
                          _passwordError = passwordValidator(_passwordController.text, null);
                          _confirmPasswordError = confirmPasswordValidator(
                              _confirmPasswordController.text,
                              _passwordController.text
                          );
                        });

                        final errors = [
                          _emailError,
                          _firstNameError,
                          _lastNameError,
                          _genderError,
                          _phoneError,
                          _countryError,
                          _passwordError,
                          _confirmPasswordError
                        ];

                        if(errors.every((error) => error == null)) {
                          FocusScope.of(context).unfocus();
                          makeRegisterRequest();
                        }
                      },
                      text: l10n.register
                  ),
                  const SizedBox(height: 50,),
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(l10n.yes_account),
                      // const SizedBox(width: 2,),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()
                              )
                          );
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(0)
                          ),
                        ),
                        child: Text(
                            l10n.login,
                            style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                                color: theme.colorScheme.primary
                            )
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
