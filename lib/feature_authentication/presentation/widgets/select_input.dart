import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectInput extends StatefulWidget {
  const SelectInput({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.onFieldSubmitted,
    required this.inputAction,
    required this.prefixIcon,
    required this.placeholder,
    required this.options,
    this.error, required this.label,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String)? onFieldSubmitted;
  final TextInputAction inputAction;
  final String placeholder;
  final String label;
  final IconData prefixIcon;
  final List<String> options;
  final String? error;

  @override
  State<SelectInput> createState() => _SelectInputState();
}

class _SelectInputState extends State<SelectInput> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: InkWell(
            onTap: () => optionsDialog(),
            child: TextFormField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              onFieldSubmitted: widget.onFieldSubmitted,
              keyboardType: TextInputType.text,
              textInputAction: widget.inputAction,
              maxLines: 1,
              enabled: false,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
                fillColor: theme.colorScheme.surface,
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Colors.grey.shade600
                    )
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                prefixIcon: Icon(widget.prefixIcon, color: theme.colorScheme.primary,),
              ),
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
        ) : Container()
      ],
    );
  }

  Future<dynamic> optionsDialog() {
    final theme = Theme.of(context);

    return showDialog(
      context: context,
      builder: (context) =>  SimpleDialog(
        title: Text(
          widget.label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: theme.colorScheme.surface,
        children: [
          for (var option in widget.options)
            SimpleDialogOption(
              onPressed: () {
                widget.controller.text = option;
                Navigator.pop(context);
              },
              child: Text(option, style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              ),
            )
        ],
      )
    );
  }
}
