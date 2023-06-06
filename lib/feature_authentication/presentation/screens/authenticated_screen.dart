import 'package:borlago/feature_authentication/presentation/screens/login_screen.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticatedScreen extends StatefulWidget {
  const AuthenticatedScreen({
    super.key,
    required this.screen
  });

  final Widget screen;

  @override
  State<AuthenticatedScreen> createState() => _AuthenticatedScreenState();
}

class _AuthenticatedScreenState extends State<AuthenticatedScreen> {
  late bool _isAuthenticated;

  @override
  void initState() {
    final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    authProvider.init();
    _isAuthenticated = authProvider.jwt != null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_isAuthenticated) {
      return widget.screen;
    } else {
      return const LoginScreen();
    }
  }
}
