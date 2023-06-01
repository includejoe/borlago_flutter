import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    Key? key,
    required this.controller,
    required this.placeholder,
    required this.focusNode,
    this.onFieldSubmitted,
    required this.inputAction,
    this.error
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String)? onFieldSubmitted;
  final TextInputAction inputAction;
  final String placeholder;
  final String? error;


  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onFieldSubmitted,
            textInputAction: widget.inputAction,
            keyboardType: TextInputType.text,
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
                prefixIcon: Icon(Icons.lock, color: theme.colorScheme.primary,),
                suffixIcon: IconButton(
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                )
            ),
          ),
        ),
        widget.error != null ?
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 0, 8),
          child: Text(
            widget.error!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ) :  Container()
      ],
    );
  }
}
