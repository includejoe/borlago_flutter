import 'package:borlago/feature_user/presentation/screens/proile_screen.dart';
import 'package:borlago/feature_user/presentation/widgets/confirm_logout_dialog.dart';
import 'package:borlago/feature_user/presentation/widgets/settings_item.dart';
import 'package:borlago/feature_user/presentation/widgets/theme_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final settingsItems = <SettingsItem>[
      SettingsItem(
        icon: CupertinoIcons.person_fill,
        text: "Edit Profile",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ProfileScreen()
            )
          );
        },
      ),
      const SettingsItem(
        icon: CupertinoIcons.sun_max_fill,
        text: "Dark Theme",
        suffixWidget: ThemeSwitch(),
      ),
      SettingsItem(
        icon: CupertinoIcons.power,
        text: "Logout",
        onTap: () {
          confirmLogoutDialog(context);
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          l10n!.settings,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12)
          ),
          color: theme.scaffoldBackgroundColor,
        ),
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: settingsItems.length,
            itemBuilder: (context, index) {
              return settingsItems[index];
            }
          )
        ),
    );
  }
}
