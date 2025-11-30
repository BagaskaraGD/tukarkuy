import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProfileSectionButton extends StatelessWidget {
  const ProfileSectionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.press,
  });

  final String text, icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Color(0xFFF2F6F5)),
          padding: WidgetStateProperty.all(EdgeInsets.all(20)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
        onPressed: press,
        child: Row(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(24),
              child: SvgPicture.asset(icon, width: 20, color: kPrimaryColor),
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            Text(text, style: TextStyle(color: Colors.black54)),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );
  }
}
