import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../size_config.dart';
import 'profile_picture.dart';

class ProfileEditScreen extends StatelessWidget {
  static const routeName = "/profile_edit";

  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ubah Profil")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(20)),
          child: Column(
            children: [
              // ProfilePicture removed from here
              SizedBox(height: getProportionateScreenHeight(20)),
              ProfileEditForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileEditForm extends StatefulWidget {
  const ProfileEditForm({super.key});

  @override
  _ProfileEditFormState createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String? name;
  String? phoneNumber;
  String? address;
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ProfilePicture(
            imageFile: _image,
            onImageSelect: _pickImage,
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(40)),
          SizedBox(
            width: double.infinity,
            height: getProportionateScreenHeight(56),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Color(0xFFFF7643),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Implement save functionality here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Profil berhasil diperbarui (Simulasi)"),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text(
                "Simpan",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Masukkan alamat Anda");
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Masukkan alamat Anda");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Alamat",
        hintText: "Masukkan alamat lengkap",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.location_on_outlined),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Masukkan nomor WhatsApp");
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Masukkan nomor WhatsApp");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Nomor WhatsApp",
        hintText: "Masukkan nomor WhatsApp",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone_android_outlined),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Masukkan nama Anda");
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Masukkan nama Anda");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Nama",
        hintText: "Masukkan nama lengkap",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }
}
