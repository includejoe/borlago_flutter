import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/base/presentation/widgets/confirmationDialog.dart';
import 'package:borlago/base/presentation/widgets/float_action_button.dart';
import 'package:borlago/base/presentation/widgets/main_page_view.dart';
import 'package:borlago/base/utils/datetime_formatter.dart';
import 'package:borlago/base/utils/toast.dart';
import 'package:borlago/base/utils/wcr_status.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:borlago/feature_wcr/domain/models/wcr.dart';
import 'package:borlago/feature_wcr/presentation/screens/make_payment_screen.dart';
import 'package:borlago/feature_wcr/presentation/screens/wcrs_screen.dart';
import 'package:borlago/feature_wcr/presentation/wcr_view_model.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WCRDetailScreen extends StatefulWidget {
  const WCRDetailScreen({super.key, required this.wcr});
  final WCR wcr;

  @override
  State<WCRDetailScreen> createState() => _WCRDetailScreenState();
}

class _WCRDetailScreenState extends State<WCRDetailScreen> {
  final WCRViewModel _wcrViewModel = WCRViewModel();

  void navigateToWCRsScreen() {
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final imageUrl = widget.wcr.wastePhoto;
    final wcrStatusData = wcrStatus(context, widget.wcr.status);
    final createdAt = formatDateTime(widget.wcr.createdAt);
    final collectedAt = formatDateTime(widget.wcr.collectionDatetime);
    final currency = getIt.get<AuthenticationProvider>().currency;

    void deleteWCR() async {
      bool success = false;
      success = await _wcrViewModel.deleteWCR(
        wcrId: widget.wcr.id,
        photoUrl: widget.wcr.wastePhoto
      );

      if (success) {
        navigateToWCRsScreen();
      } else {
        toast(message: l10n!.err_wrong);
      }
    }

    void cancelWCR() async {
      WCR? wcr;
      wcr = await _wcrViewModel.cancelWCR(wcrId: widget.wcr.id);
      if (wcr != null) {
        navigateToWCRsScreen();
      } else {
        toast(message: l10n!.err_wrong);
      }
    }

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
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.exclamationmark_circle_fill,
                          size: 50,
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          l10n.err_wrong,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium
                        ),
                      ],
                    ),
                  );
                },
                loadingBuilder: (context, progress) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      if (progress.isDownloading && progress.totalBytes != null)
                        Text(
                          '${progress.downloadedBytes ~/ 1024} / ${progress.totalBytes! ~/ 1024} kb',
                          style: theme.textTheme.bodyMedium
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
                      widget.wcr.publicId,
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
                        widget.wcr.wasteType,
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
                        widget.wcr.collectorUnit ?? l10n.txt_na,
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
                      wcrStatusData["statusText"],
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color:  wcrStatusData["statusColor"],
                        fontStyle: FontStyle.italic
                      )
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
                        widget.wcr.pickUpLocation,
                        style: theme.textTheme.bodyMedium
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      "${l10n.lbl_price}:",
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                        "$currency ${widget.wcr.price}",
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
                        createdAt ?? l10n.txt_na,
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
                        collectedAt ?? l10n.txt_na,
                        style: theme.textTheme.bodyMedium
                    ),
                  ],
                ),
                widget.wcr.status == 1 || widget.wcr.status == 2 ?
                  Column(
                    children: [
                      const SizedBox(height: 20,),
                      Button(
                        backgroundColor: widget.wcr.status == 2 ? theme.colorScheme.error :
                          theme.colorScheme.primary,
                        text: widget.wcr.status == 1 ? l10n.btn_c_make_payment :
                          widget.wcr.status == 2 ? l10n.btn_cancel_request : "",
                        onTap: () {
                          if(widget.wcr.status == 1) {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return MakePaymentScreen(wcr: widget.wcr);
                                })
                            );
                          } else if(widget.wcr.status == 2) {
                            confirmationDialog(
                              context: context,
                              title: l10n.txt_cancel_request,
                              yesAction: cancelWCR
                            );
                          }
                        }
                      )
                    ],
                  )
                  : Container(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: widget.wcr.status == 1 ?
      FloatActionButton(
        onPressed: () {
          confirmationDialog(
            context: context,
            title: l10n.txt_confirm_delete,
            yesAction: deleteWCR
          );
        },
        icon: Icons.delete,
      ) : Container(),
    );
  }
}
