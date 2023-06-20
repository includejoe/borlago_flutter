import 'package:borlago/base/presentation/widgets/app_logo.dart';
import 'package:borlago/base/presentation/widgets/loader.dart';
import 'package:borlago/base/presentation/widgets/main_page_view.dart';
import 'package:borlago/base/utils/form_validators/email.dart';
import 'package:borlago/base/utils/form_validators/password.dart';
import 'package:borlago/base/utils/toast.dart';
import 'package:borlago/feature_authentication/presentation/auth_view_model.dart';
import 'package:borlago/feature_authentication/presentation/screens/forgot_password_screen.dart';
import 'package:borlago/feature_authentication/presentation/screens/register_screen.dart';
import 'package:borlago/base/presentation/widgets/password_input.dart';
import 'package:borlago/feature_authentication/presentation/widgets/bottom_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/base/presentation/widgets/text_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthenticationViewModel _authViewModel = AuthenticationViewModel();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // focus nodes
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  // errors
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final emailValidator = EmailValidator(context);
    final passwordValidator = PasswordValidator(context, false);
    void navigateToMainScreen() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPageView()
        )
      );
    }

    void makeLoginRequest() async {
      setState(() {
        _isLoading = true;
      });

      bool success = await _authViewModel.login(
        email: _emailController.text,
        password: _passwordController.text
      );

      setState(() {
        _isLoading = false;
      });

      if(success) {
        _emailController.clear();
        _passwordController.clear();
        navigateToMainScreen();
      } else {
        toast(message: l10n!.err_invalid_credentials);
      }
    }

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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: const Center(child: AppLogo()),
                  ),
                  TextInput(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    focusNode: _emailFocusNode,
                    inputAction: TextInputAction.next,
                    prefixIcon: CupertinoIcons.envelope_fill,
                    label: l10n!.lbl_email,
                    placeholder: l10n.plh_email,
                    error: _emailError,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                  const SizedBox(height: 15,),
                  PasswordInput(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      inputAction: TextInputAction.done,
                      error: _passwordError,
                      label: l10n.lbl_password,
                      placeholder: l10n.plh_password,
                      showIcon: true,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).unfocus();
                      },
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    padding: const EdgeInsets.only(right: 5),
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const ForgotPasswordScreen())
                        );
                      },
                      child: Text(
                        l10n.txt_forgot_password,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontSize: 12.0,
                          color: theme.colorScheme.primary
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  _isLoading ? const Loader(size: 24) : Button(
                    text: l10n.btn_login,
                    onTap: () {
                      setState(() {
                        _emailError = emailValidator(_emailController.text);
                        _passwordError = passwordValidator(_passwordController.text, null);
                      });

                      final errors = [_emailError, _passwordError];

                      if(errors.every((error) => error == null)) {
                        FocusScope.of(context).unfocus();
                        makeLoginRequest();
                      }
                    },
                  ),
                  BottomAction(
                    info: l10n.txt_no_account,
                    btnText: l10n.btn_register,
                    action: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()
                          )
                      );
                    }
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}