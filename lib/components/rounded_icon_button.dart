import 'package:flutter/material.dart';

import '../size_config.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({super.key, required this.icon, required this.press});

  final icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(40),
      height: getProportionateScreenHeight(40),
      child: TextButton(
        onPressed: press,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.white),
        ),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }
}
