import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:borlago/feature_user/domain/models/payment_method.dart';
import 'package:borlago/feature_user/presentation/screens/payment_method_detail_screen.dart';
import 'package:borlago/feature_user/presentation/widgets/payment_method_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentMethodItem extends StatefulWidget {
  const PaymentMethodItem({
    super.key,
    required this.method,
  });

  final PaymentMethod method;

  @override
  State<PaymentMethodItem> createState() => _PaymentMethodItemState();
}

class _PaymentMethodItemState extends State<PaymentMethodItem> {
  late PaymentType? _type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = getIt.get<AuthenticationProvider>().user;
    final l10n = AppLocalizations.of(context);

    // assign the appropriate payment type to the method
    Constants.paymentTypes.forEach((key, value) {
      if(key == user!.country) {
        for (var type in value) {
          if(type.name == widget.method.name) {
            _type = type;
          }
        }
      }
    });

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                PaymentMethodLogo(logoUrl: _type!.logo, size: 35),
                const SizedBox(width: 12),
                Text(
                  transformAccountNumber(widget.method.accountNumber),
                  style: theme.textTheme.bodyMedium
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PaymentMethodDetailScreen(
                      method: widget.method,
                      type: _type!,
                    )
                ));
              },
              child: const Icon(
                CupertinoIcons.pencil,
              ),
            )
          ],
        ),
      ),
    );
  }

  String transformAccountNumber(String number) {
    if (number.length <= 3) {
      return number;
    }

    String lastThreeChars = number.substring(number.length - 3);
    String transformedNumber = '';

    for (int i = 0; i < number.length - 3; i++) {
      transformedNumber += '●';
    }

    transformedNumber += lastThreeChars;
    return transformedNumber;
  }
}
