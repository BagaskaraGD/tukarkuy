import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.onChanged,
    this.readOnly = false,
    this.onTap,
  });

  final ValueChanged<String> onChanged;
  final bool readOnly;
  final VoidCallback? onTap;

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
        onChanged: onChanged,
        readOnly: readOnly,
        onTap: onTap,
        textInputAction: TextInputAction.search,
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
