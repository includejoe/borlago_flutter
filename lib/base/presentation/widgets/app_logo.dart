import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Image.asset(
      "assets/images/text_logo.png",
      color: theme.colorScheme.primary,
    );
  }
}
