import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({super.key, required this.text, required this.press});
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(kPrimaryColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        minimumSize: WidgetStateProperty.all(
          Size(
            getProportionateScreenWidth(double.infinity),
            getProportionateScreenHeight(56),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: getProportionateScreenWidth(18)),
      ),
    );
  }
}
