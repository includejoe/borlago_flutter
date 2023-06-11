import 'package:borlago/base/utils/datetime_formatter.dart';
import 'package:borlago/base/utils/wcr_status.dart';
import 'package:borlago/feature_wcr/domain/models/wcr.dart';
import 'package:borlago/feature_wcr/presentation/screens/wcr_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WCRItem extends StatelessWidget {
  const WCRItem({
    super.key,
    required this.wcr,
    required this.fetchWCRs,
  });
  final WCR wcr;
  final void Function() fetchWCRs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String? formattedTime = formatDateTime(wcr.createdAt);
    final wcrStatusData = wcrStatus(context, wcr.status);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 75,
      decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
              bottom: BorderSide(
                  width: 1,
                  color: theme.colorScheme.background
              )
          )
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WCRDetailScreen(wcr: wcr)
            )
          ).then((value) => fetchWCRs());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    borderRadius: BorderRadius.circular(100)
                ),
                child: Icon(
                  CupertinoIcons.trash_fill,
                  size: 30,
                  color: wcrStatusData["statusColor"]
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          wcr.publicId,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          formattedTime!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: theme.colorScheme.onBackground.withOpacity(0.7)
                          ),
                        ),
                      ],
                    ),
                    Text(
                      wcr.wasteType,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                      )
                    ),
                    Text(
                      wcrStatusData["statusText"],
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: wcrStatusData["statusColor"]
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
