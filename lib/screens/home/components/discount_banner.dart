import 'package:flutter/material.dart';

import '../../../size_config.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenHeight(18),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFE6E8FF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Text.rich(
          TextSpan(
            text: "Tukar Barangmu Sekarang!\n",
            style: TextStyle(
              color: const Color(0xFF4D4FB1),
              fontWeight: FontWeight.w700,
              fontSize: getProportionateScreenWidth(15),
            ),
            children: const [
              TextSpan(
                text: "Kurangi limbah, bantu sesama,\n"
                    "dan temukan barang impianmu.",
                style: TextStyle(
                  color: Color(0xFF4D4FB1),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
