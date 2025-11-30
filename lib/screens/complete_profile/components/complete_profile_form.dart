import 'package:flutter/material.dart';
import 'package:tukarkuy/screens/otp/otp_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_suffix_icon.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String? firstName, lastName, phone, address;
  final List<String> errors = [];
  bool firstSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Continue",
            press: () {
              // PERBAIKAN: Tambahkan '!' untuk memastikan tidak null
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Navigasi ke OTP Screen
                Navigator.pushNamed(
                  context,
                  OTPScreen.routeName,
                  arguments: phone,
                );
              }
              firstSubmit = true;
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newName) => firstName = newName,
      onChanged: (name) {
        if (firstSubmit) {
          _formKey.currentState?.validate(); // Gunakan '?' untuk safe call
        }
      },
      validator: (name) {
        // PERBAIKAN: Periksa null sebelum memeriksa .isEmpty
        if (name == null || name.isEmpty) {
          return kFirstNamelNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        suffixIcon: CustomSuffixIcon(
          iconPath: "assets/icons/User.svg",
        ), // Pastikan path icon benar
      ),
      keyboardType: TextInputType.name,
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newName) => lastName = newName,
      onChanged: (name) {
        if (firstSubmit) {
          _formKey.currentState?.validate(); // Gunakan '?' untuk safe call
        }
      },
      validator: (name) {
        // PERBAIKAN: Periksa null sebelum memeriksa .isEmpty
        if (name == null || name.isEmpty) {
          return kLastNamelNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        suffixIcon: CustomSuffixIcon(
          iconPath: "assets/icons/User.svg",
        ), // Pastikan path icon benar
      ),
      keyboardType: TextInputType.name,
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      onSaved: (newPhone) => phone = newPhone,
      onChanged: (phone) {
        if (firstSubmit) {
          _formKey.currentState?.validate(); // Gunakan '?' untuk safe call
        }
      },
      validator: (phone) {
        // PERBAIKAN: Periksa null sebelum memeriksa .isEmpty
        if (phone == null || phone.isEmpty) {
          return kPhoneNumberNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Phone.svg"),
      ),
      keyboardType: TextInputType.phone,
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newAddress) => address = newAddress,
      onChanged: (address) {
        if (firstSubmit) {
          _formKey.currentState?.validate(); // Gunakan '?' untuk safe call
        }
      },
      validator: (address) {
        // PERBAIKAN: Periksa null sebelum memeriksa .isEmpty
        if (address == null || address.isEmpty) {
          return kAddressNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your address",
        suffixIcon: CustomSuffixIcon(
          iconPath: "assets/icons/Location point.svg",
        ),
      ),
      keyboardType: TextInputType.streetAddress,
    );
  }
}
