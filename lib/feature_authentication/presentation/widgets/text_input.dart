import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.controller,
    required this.textInputType,
    required this.focusNode,
    this.onFieldSubmitted,
    required this.inputAction,
    this.error
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String)? onFieldSubmitted;
  final TextInputAction inputAction;
  final TextInputType textInputType;
  final String? error;


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
            controller: controller,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            keyboardType: textInputType,
            textInputAction: inputAction,
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
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary
                  )
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Colors.grey.shade100
                  )
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              prefixIcon: Icon(Icons.email, color: theme.colorScheme.primary,),
            ),
          ),
        ),
        error != null ?
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 0, 8),
          child: Text(
            error!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ) : Container()
      ],
    );
  }
}
