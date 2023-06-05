import 'package:flutter/material.dart';

class TextItem extends StatelessWidget {
  const TextItem({super.key, this.onTap, required this.text});

  final void Function()? onTap;
  final String text;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Text(text, style: theme.textTheme.bodyMedium),
        ),
      ),
    );
  }
}
