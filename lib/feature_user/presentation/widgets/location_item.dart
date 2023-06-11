import 'package:borlago/base/presentation/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationItem extends StatefulWidget {
  const LocationItem({
    super.key,
    required this.name,
    required this.onDeletePressed
  });
  final String name;
  final void Function() onDeletePressed;

  @override
  State<LocationItem> createState() => _LocationItemState();
}

class _LocationItemState extends State<LocationItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.name, style: theme.textTheme.bodyMedium),
            InkWell(
              onTap: () {
                confirmationDialog(
                  context: context,
                  title: l10n!.txt_confirm_delete,
                  yesAction: widget.onDeletePressed
                );
              },
              child: Icon(
                Icons.delete,
                color: theme.colorScheme.error
              ),
            )
          ],
        ),
      ),
    );
  }
}
