import 'package:borlago/base/utils/datetime_formatter.dart';
import 'package:borlago/feature_wcr/presentation/screens/wcr_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WCRItem extends StatelessWidget {
  const WCRItem({
    super.key,
    required this.id,
    required this.time,
    required this.status,
    required this.wasteType,

  });

  final String id;
  final String time;
  final int status;
  final String wasteType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String statusText = "";
    Color statusColor = Colors.transparent;
    String formattedTime = formatDateTime(time);

    if(status == 1) {
      statusText = "Pending";
      statusColor = Colors.grey.shade600;
    } else if(status == 2) {
      statusText = "In Progress";
      statusColor = Colors.yellow.shade900;
    } else if(status == 3) {
      statusText = "Completed";
      statusColor = Colors.green.shade900;
    } else if(status == 4) {
      statusText = "Canceled";
      statusColor = Colors.red.shade600;
    }


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
              builder: (context) => WCRDetailScreen(wcrId: id)
            )
          );
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
                  color: statusColor
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
                          id,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          formattedTime,
                          style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: theme.colorScheme.onBackground.withOpacity(0.7)
                          ),
                        ),
                      ],
                    ),
                    Text(
                      wasteType,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                      )
                    ),
                    Text(
                      statusText,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: statusColor
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
