import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key}); // Perbaikan: Tambahkan konstruktor modern

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    // PERBAIKAN: Gunakan '?.' untuk memanggil dispose dengan aman
    pin2FocusNode?.dispose();
    pin3FocusNode?.dispose();
    pin4FocusNode?.dispose();
    super.dispose();
  }

  // PERBAIKAN: Perbarui signature method agar null-safe
  void nextNode({required String value, required FocusNode? focusNode}) {
    if (value.length == 1) {
      // PERBAIKAN: Gunakan '?.' untuk request focus dengan aman
      focusNode?.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              autofocus: true,
              obscureText: true,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
              decoration: otpInputDecoration,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                nextNode(value: value, focusNode: pin2FocusNode);
              },
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              focusNode: pin2FocusNode,
              style: TextStyle(fontSize: 24),
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: otpInputDecoration,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                nextNode(value: value, focusNode: pin3FocusNode);
              },
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              focusNode: pin3FocusNode,
              style: TextStyle(fontSize: 24),
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: otpInputDecoration,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                nextNode(value: value, focusNode: pin4FocusNode);
              },
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              focusNode: pin4FocusNode,
              style: TextStyle(fontSize: 24),
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: otpInputDecoration,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // PERBAIKAN: Gunakan '?.' untuk unfocus dengan aman
                if (value.length == 1) {
                  pin4FocusNode?.unfocus();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
