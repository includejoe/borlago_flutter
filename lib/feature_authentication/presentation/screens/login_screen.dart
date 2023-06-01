import 'package:borlago/base/utils/form_validators/email.dart';
import 'package:borlago/base/utils/form_validators/password.dart';
import 'package:borlago/feature_authentication/presentation/screens/register_screen.dart';
import 'package:borlago/feature_authentication/presentation/widgets/password_input.dart';
import 'package:flutter/material.dart';
import 'package:borlago/base/utils/dimensions.dart';
import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/feature_authentication/presentation/widgets/text_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // email values
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  String? _emailError;

  // password values
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    final emailValidator = EmailValidator(context);
    final passwordValidator = PasswordValidator(context);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: screenHeight(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextInput(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    inputAction: TextInputAction.next,
                    error: _emailError,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    textInputType: TextInputType.emailAddress,
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
                      placeholder: l10n!.ph_password
                  ),
                  const SizedBox(height: 15,),
                  Button(
                    onTap: () {
                      setState(() {
                        _emailError = emailValidator(_emailController.text);
                        _passwordError = passwordValidator(_passwordController.text);
                      });

                      if(_emailError == null && _passwordError == null) {
                        _emailController.clear();
                        _passwordController.clear();
                        FocusScope.of(context).unfocus();
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
            ),
          )
        ),
      ),
    );
  }
}
