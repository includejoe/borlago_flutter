import 'package:borlago/feature_wcr/presentation/widgets/wcr_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WCRsScreen extends StatelessWidget {
  const WCRsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    const wcrItems = <WCRItem>[
      WCRItem(
        id: "02388546",
        time: "Today, 12:47 PM",
        status: 1,
        wasteType: "General Waste"
      ),
      WCRItem(
          id: "1886476",
          time: "Yesterday, 8:06 AM",
          status: 2,
          wasteType: "General Waste"
      ),
      WCRItem(
        id: "02386476",
        time: "01/06/23, 4:54 PM",
        status: 4,
        wasteType: "Organic Waste"
      ),
      WCRItem(
        id: "02386476",
        time: "12/05/23, 1:13 PM",
        status: 3,
        wasteType: "Hazardous Waste"
      )
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          l10n!.lbl_wcrs,
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
              itemCount: wcrItems.length,
              itemBuilder: (context, index) {
                return wcrItems[index];
              }
          )
      ),
    );
  }
}
