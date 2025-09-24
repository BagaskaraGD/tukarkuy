import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/no_account_text.dart';
import '../../../components/custom_suffix_icon.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  bool firstSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: TextFormField(
            onSaved: (newEmail) => email = newEmail,
            onChanged: (email) {
              if (firstSubmit) {
                // PERBAIKAN: Gunakan '?' untuk memanggil validate jika state tidak null
                _formKey.currentState?.validate();
              }
            },
            validator: (email) {
              // PERBAIKAN: Cek apakah email null atau kosong
              if (email == null || email.isEmpty) {
                return kEmailNullError;
              } else if (!emailValidatorRegExp.hasMatch(email)) {
                return kInvalidEmailError;
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Mail.svg"),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.1),
        DefaultButton(
          text: 'Continue',
          press: () {
            // PERBAIKAN: Tambahkan '!' karena kita yakin form ada saat tombol ditekan
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // Kirim email atau lakukan aksi selanjutnya
            }
            firstSubmit = true;
          },
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.1),
        NoAccountText(),
      ],
    );
  }
}
