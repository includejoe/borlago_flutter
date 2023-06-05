import 'package:borlago/feature_notifications/presentation/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    const notificationItems = <NotificationItem>[
      NotificationItem(
        label: "Payment Successful",
        body: "Your payment for waste collection request 0321545 has been completed, successfully",
        time: "Today, 2:27 PM",
        opened: false
      ),
      NotificationItem(
          label: "Waste Collected",
          body: "Your waste collection request 0321545 has been completed successfully",
          time: "Yesterday, 5:27 PM",
          opened: true
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          l10n!.notifications,
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
            itemCount: notificationItems.length,
            itemBuilder: (context, index) {
              return notificationItems[index];
            }
        )
      ),
    );
  }
}
