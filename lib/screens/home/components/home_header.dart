import 'package:flutter/material.dart';
import './search_field.dart';
import '../../../size_config.dart';
import './icon_button_with_counter.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.onSearchChanged,
    this.searchReadOnly = false,
    this.onSearchTap,
  });

  final ValueChanged<String> onSearchChanged;
  final bool searchReadOnly;
  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(
            onChanged: onSearchChanged,
            readOnly: searchReadOnly,
            onTap: onSearchTap,
          ),
          IconButtonWithCounter(
            svgSrc: 'assets/icons/Heart Icon.svg',
            noOfItems: 1,
            press: () {},
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
