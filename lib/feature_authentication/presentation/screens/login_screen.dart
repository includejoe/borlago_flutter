import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/base/presentation/widgets/app_logo.dart';
import 'package:borlago/base/utils/form_validators/email.dart';
import 'package:borlago/base/utils/form_validators/password.dart';
import 'package:borlago/feature_authentication/presentation/auth_view_model.dart';
import 'package:borlago/feature_authentication/presentation/screens/register_screen.dart';
import 'package:borlago/feature_authentication/presentation/widgets/password_input.dart';
import 'package:borlago/feature_wcr/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/feature_authentication/presentation/widgets/text_input.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthenticationViewModel authViewModel = getIt<AuthenticationViewModel>();

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
              builder: (context) => const MainScreen()
          )
      );
    }

    void makeLoginRequest() async {
      setState(() {
        _isLoading = true;
      });

      bool success = await authViewModel.login(
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
        Fluttertoast.showToast(
          msg: l10n!.err_invalid_credentials,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.grey.shade900,
          gravity: ToastGravity.BOTTOM,
        );
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
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
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                  const SizedBox(height: 15,),
                  PasswordInput(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      inputAction: TextInputAction.done,
                      error: _passwordError,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      placeholder: l10n.plh_password
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
                        _passwordError = passwordValidator(_passwordController.text, null);
                      });

                      final errors = [_emailError, _passwordError];

                      if(errors.every((error) => error == null)) {
                        FocusScope.of(context).unfocus();
                        makeLoginRequest();
                      }
                    },
                    text: l10n.login
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
                      Text(l10n.no_account),
                      const SizedBox(width: 5,),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen()
                            )
                          );
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(0)
                          ),
                        ),
                        child: Text(
                          l10n.register,
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
            )
          ),
        ),
      ),
    );


  }
}
