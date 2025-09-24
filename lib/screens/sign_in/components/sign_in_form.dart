import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_suffix_icon.dart';
import '../../login_success/login_success_screen.dart';
import '../../forgot_password/forgot_password_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key}); // Tambahkan konstruktor

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email, password;
  bool firstSubmit = false;
  bool remember = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                // PERBAIKAN: Tangani nilai null dari onChanged
                onChanged: (value) => setState(() => remember = value ?? false),
              ),
              const Text("Remember me"),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  ForgotPasswordScreen.routeName,
                ),
                child: const Text("Forgot password"),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Continue",
            press: () {
              // PERBAIKAN: Gunakan '!' karena kita yakin form sudah ada
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
              firstSubmit = true;
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      onSaved: (newPassword) => password = newPassword,
      onChanged: (password) {
        if (firstSubmit) {
          // PERBAIKAN: Gunakan '?.' untuk safe call
          _formKey.currentState?.validate();
        }
      },
      validator: (password) {
        // PERBAIKAN: Cek null sebelum cek properti lainnya
        if (password == null || password.isEmpty) {
          return kPassNullError;
        } else if (password.length <= 7) {
          return kShortPassError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Lock.svg"),
      ),
      obscureText: true,
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      onSaved: (newEmail) => email = newEmail,
      onChanged: (email) {
        if (firstSubmit) {
          // PERBAIKAN: Gunakan '?.' untuk safe call
          _formKey.currentState?.validate();
        }
      },
      validator: (email) {
        // PERBAIKAN: Cek null sebelum cek properti lainnya
        if (email == null || email.isEmpty) {
          return kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(email)) {
          return kInvalidEmailError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Mail.svg"),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
