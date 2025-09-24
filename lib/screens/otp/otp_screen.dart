import 'package:flutter/material.dart';

import './components/body.dart';

class OTPScreen extends StatelessWidget {
  // PERBAIKAN 1: Tambahkan konstruktor modern dengan super.key
  const OTPScreen({super.key});
  static const routeName = '/otp';

  @override
  Widget build(BuildContext context) {
    // PERBAIKAN 2 & 3: Tambahkan '!' dan lakukan casting ke String
    final phone = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: const Text("OTP Verification")),
      body: Body(phone),
    );
  }
}
