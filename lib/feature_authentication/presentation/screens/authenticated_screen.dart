import 'package:borlago/feature_authentication/presentation/screens/login_screen.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticatedScreen extends StatelessWidget {
  const AuthenticatedScreen({
    super.key,
    required this.screen
  });

  final Widget screen;

  @override
  Widget build(BuildContext context) {
    bool isAuthenticated = context.read<AuthenticationProvider>().jwt != null;

    if(isAuthenticated) {
      return screen;
    } else {
      return const LoginScreen();
    }
  }
}
