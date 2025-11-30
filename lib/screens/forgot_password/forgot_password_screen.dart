import 'package:flutter/material.dart';

import './components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = '/forgot-password';

  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot password"),
      ),
      body: Body(),
    );
  }
}
