import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * .63,
      height: getProportionateScreenHeight(46),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        onChanged: (value) {
          // search value
        },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(16),
            vertical: getProportionateScreenHeight(10),
          ),
          hintText: "Search product...",
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: getProportionateScreenWidth(12),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey.shade500,
            size: getProportionateScreenWidth(18),
          ),
        ),
      ),
    );
  }
}
