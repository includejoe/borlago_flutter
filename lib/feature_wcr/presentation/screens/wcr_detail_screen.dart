import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WCRDetailScreen extends StatefulWidget {
  const WCRDetailScreen({super.key, required this.wcrId});
  final String wcrId;

  @override
  State<WCRDetailScreen> createState() => _WCRDetailScreenState();
}

class _WCRDetailScreenState extends State<WCRDetailScreen> {
  final String imageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqnCCoztXLXIUPW7r7iypMPTwURDcx62SIQg&usqp=CAU";

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          l10n!.lbl_wcr_detail,
          style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: BoxDecoration(
                color: theme.colorScheme.surface
            ),
            child: AspectRatio(
              aspectRatio: 9 / 6,
              child: FastCachedImage(
                url: imageUrl,
                fadeInDuration: const Duration(seconds: 1),
                errorBuilder: (context, exception, stacktrace) {
                  return Text(stacktrace.toString());
                },
                loadingBuilder: (context, progress) {
                  debugPrint(
                      'Progress: ${progress.isDownloading} ${progress.downloadedBytes} / ${progress.totalBytes}');
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      if (progress.isDownloading && progress.totalBytes != null)
                        Text(
                          '${progress.downloadedBytes ~/ 1024} / ${progress.totalBytes! ~/ 1024} kb',
                          style: const TextStyle(color: Colors.red)
                        ),
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: CircularProgressIndicator(
                            color: theme.colorScheme.primary,
                            value: progress.progressPercentage.value
                          )
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "${l10n.lbl_id}:",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      "132547945",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      "${l10n.lbl_waste_type}:",
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                        "General",
                        style: theme.textTheme.bodyMedium
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      "${l10n.lbl_collector_unit}:",
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                        "GHA0001",
                        style: theme.textTheme.bodyMedium
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      "${l10n.lbl_status}:",
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                        "Pending",
                        style: theme.textTheme.bodyMedium
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      "${l10n.lbl_location}:",
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                        "Accra, Tesano - Glass Hostel",
                        style: theme.textTheme.bodyMedium
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      "${l10n.lbl_payment}:",
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                        "GHC 5.47",
                        style: theme.textTheme.bodyMedium
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      "${l10n.lbl_created_at}:",
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                        "05/06/23",
                        style: theme.textTheme.bodyMedium
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      "${l10n.lbl_collected_at}:",
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                        l10n.txt_na,
                        style: theme.textTheme.bodyMedium
                    ),
                  ],
                ),

              ],
            ),
          )
        ],
      )
    );
  }
}
