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
  final _form = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    // TODO: Do not clear form field values if validation error
    // TODO: put l10n in form validators
    // TODO: add login illustration



    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: _form,
            child: SizedBox(
              height: screenHeight(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextInput(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15,),
                  PasswordInput(
                      controller: _passwordController,
                      placeholder: l10n!.ph_password
                  ),
                  const SizedBox(height: 15,),
                  Button(
                    onTap: () {
                      if(_form.currentState!.validate()) {
                        _emailController.clear();
                        _passwordController.clear();
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
