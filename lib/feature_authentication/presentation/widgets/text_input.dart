import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:borlago/feature_authentication/utils/form_validators/email.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    Key? key,
    required this.controller,
    required this.textInputType
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType textInputType;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  EmailValidator validator = EmailValidator();

   String? validationError;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: TextFormField(
            keyboardType: widget.textInputType,
            controller: widget.controller,
            maxLines: 1,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              hintText: l10n!.ph_email,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
              fillColor: theme.colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              prefixIcon: Icon(Icons.email, color: theme.colorScheme.primary,),
            ),
            validator: (value) {
              setState(() {
                validationError = validator(value!);
              });
              return null;
            },
          ),
        ),
        validationError != null ?
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 0, 8),
          child: Text(
            validationError!,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ) : Container()
      ],
    );
  }
}
