import 'package:flutter/material.dart';
import 'package:tukarkuy/screens/cart/cart_screen.dart';

import './search_field.dart';
import '../../../size_config.dart';
import './icon_button_with_counter.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconButtonWithCounter(
            svgSrc: 'assets/icons/Cart Icon.svg',
            noOfItems: 1,
            press: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
          IconButtonWithCounter(
            svgSrc: 'assets/icons/Bell.svg',
            noOfItems: 1,
            press: () {},
          ),
        ],
      ),
    );
  }
}
