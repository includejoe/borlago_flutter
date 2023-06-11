import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Map<String, dynamic> wcrStatus(BuildContext context, int status) {
  final l10n = AppLocalizations.of(context);

  Map<String, dynamic> map = {
    "statusText": null,
    "statusColor": null,
  };

  if(status == 1) {
    map["statusText"] = l10n!.txt_pending;
    map["statusColor"] = Colors.grey.shade600;
  } else if(status == 2) {
    map["statusText"] = l10n!.txt_progress;
    map["statusColor"] = Colors.yellow.shade900;
  } else if(status == 3) {
    map["statusText"] = l10n!.txt_completed;
    map["statusColor"] = Colors.green.shade900;
  } else if(status == 4) {
    map["statusText"] = l10n!.txt_canceled;
    map["statusColor"] = Colors.red.shade600;
  }

  return map;
}