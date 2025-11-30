import 'package:flutter/material.dart';

import './components/body.dart';

class LoginSuccessScreen extends StatelessWidget {
  static const routeName = "/login-success";

  const LoginSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: SizedBox(),
        title: Text("Login Success"),
      ),
      body: Body(),
    );
  }
}
