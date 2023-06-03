import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateWCRScreen extends StatefulWidget {
  const CreateWCRScreen({super.key, required this.imageFile});
  final XFile imageFile;

  @override
  State<CreateWCRScreen> createState() => _CreateWCRScreenState();
}

class _CreateWCRScreenState extends State<CreateWCRScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.scaffoldBackgroundColor,
        ),
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(
            "CREATE WCR SCREEN",
            style: theme.textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
