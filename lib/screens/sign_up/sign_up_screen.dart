import 'package:flutter/material.dart';

import './components/body.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/sign-up';

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Body(),
    );
  }
}
