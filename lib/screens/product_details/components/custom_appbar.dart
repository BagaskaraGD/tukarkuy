import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';
import '../../../components/rounded_icon_button.dart';

// PERBAIKAN 1: Jadikan StatelessWidget dan implementasikan PreferredSizeWidget
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double rating;

  // PERBAIKAN 2: Gunakan konstruktor modern
  const CustomAppBar({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedIconButton(
              icon: Icons.arrow_back,
              press: () => Navigator.pop(context),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Text(
                    "$rating",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset("assets/icons/Star Icon.svg"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // PERBAIKAN 3: Override preferredSize getter
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
