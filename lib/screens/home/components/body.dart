import 'package:flutter/material.dart';

import './home_header.dart';
import './discount_banner.dart';
import './popular_products.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(18),
          ),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(8)),
              HomeHeader(),
              SizedBox(height: getProportionateScreenHeight(20)),
              DiscountBanner(),
              SizedBox(height: getProportionateScreenHeight(22)),
              PopularProducts(),
              SizedBox(height: getProportionateScreenHeight(20)),
            ],
          ),
        ),
      ),
    );
  }
}
