import 'package:flutter/material.dart';
import 'package:borlago/feature_authentication/utils/form_validators/password.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    Key? key,
    required this.controller,
    required this.placeholder
  }) : super(key: key);

  final TextEditingController controller;
  final String placeholder;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isVisible = true;
  PasswordValidator validator = PasswordValidator();
  String? validationError;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: widget.controller,
            obscureText: isVisible,
            maxLines: 1,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
                fillColor: theme.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                prefixIcon: Icon(Icons.lock, color: theme.colorScheme.primary,),
                suffixIcon: IconButton(
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color: theme.colorScheme.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                )
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
        ) :  Container()
      ],
    );
  }
}
