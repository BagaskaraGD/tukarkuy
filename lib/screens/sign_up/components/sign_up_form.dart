import 'package:flutter/material.dart';
import 'package:tukarkuy/components/custom_suffix_icon.dart';
import 'package:tukarkuy/components/default_button.dart';
import 'package:tukarkuy/constants.dart';
import 'package:tukarkuy/screens/sign_in/sign_in_screen.dart';
import 'package:tukarkuy/services/auth_service.dart';
import 'package:tukarkuy/size_config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? name, email, password, confirmPassword;
  bool firstSubmit = false;
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Tambahkan field untuk Nama
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConfirmPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () async {
              // JADIKAN ASYNC
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                bool success = await authService.register(
                  name: name!,
                  email: email!,
                  password: password!,
                  passwordConfirmation: confirmPassword!,
                );

                if (!mounted) return;

                if (success) {
                  // Jika berhasil, arahkan ke halaman login
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Registrasi berhasil! Silakan login.'),
                    ),
                  );
                  Navigator.pushNamed(context, SignInScreen.routeName);
                } else {
                  // Jika gagal, tampilkan pesan error
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Registrasi gagal. Coba lagi.'),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      onSaved: (newName) => name = newName,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your name";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Name",
        hintText: "Enter your name",
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/User.svg"),
      ),
      keyboardType: TextInputType.name,
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      onSaved: (newPassword) => confirmPassword = newPassword,
      onChanged: (value) {
        if (firstSubmit) _formKey.currentState?.validate();
      },
      validator: (value) {
        if (value != password) {
          return "Passwords do not match";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Lock.svg"),
      ),
      obscureText: true,
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      onSaved: (newPassword) => password = newPassword,
      onChanged: (value) {
        // Simpan nilai password agar bisa dibandingkan di confirm password
        password = value;
        if (firstSubmit) _formKey.currentState?.validate();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return kPassNullError;
        } else if (value.length < 8) {
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
        if (firstSubmit) _formKey.currentState?.validate();
      },
      validator: (email) {
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
