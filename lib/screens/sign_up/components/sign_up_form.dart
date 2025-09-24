import 'package:flutter/material.dart';
import 'package:tukarkuy/screens/complete_profile/complete_profile_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_suffix_icon.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key}); // Tambahkan konstruktor

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email, password, confirmPassword;
  bool firstSubmit = false;

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
          buildConfirmPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () {
              // PERBAIKAN: Gunakan '!' karena kita yakin form sudah ada
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
              firstSubmit = true;
            },
          ),
        ],
      ),
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      onSaved: (newPassword) => password = newPassword,
      onChanged: (value) {
        // Simpan nilai password setiap kali berubah untuk validasi konfirmasi
        password = value;
        if (firstSubmit) {
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

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      onSaved: (newPassword) => confirmPassword = newPassword,
      onChanged: (password) {
        if (firstSubmit) {
          _formKey.currentState?.validate();
        }
      },
      validator: (value) {
        // PERBAIKAN: Cek null dan pastikan sama dengan password
        if (value == null || value.isEmpty) {
          return "Please re-enter your password";
        }
        if (value != password) {
          return kMatchPassError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Confirm Password",
        hintText: "Repeat your password",
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Lock.svg"),
      ),
      obscureText: true,
    );
  }
}
