import 'package:flutter/material.dart';

class PaymentMethodLogo extends StatelessWidget {
  const PaymentMethodLogo({super.key, required this.logoUrl, required this.size});
  final String logoUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: ClipOval(
          child: Image.asset(
            logoUrl,
            height: size,
            width: size,
            fit: BoxFit.contain,
          ),
        )
    );
  }
}
