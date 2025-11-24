import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tukarkuy/models/user_model.dart';
import 'package:tukarkuy/services/user_service.dart';
import '../../../size_config.dart';
import 'profile_picture.dart';

class ProfileEditScreen extends StatelessWidget {
  static const routeName = "/profile_edit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ubah Profil")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(20)),
          child: Column(
            children: [
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
  @override
  _ProfileEditFormState createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  final UserService _userService = UserService();
  
  String? name;
  String? phoneNumber;
  String? address;
  File? _image;
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true;
    });
    
    UserModel? user = await _userService.getUser();
    
    if (user != null) {
      setState(() {
        name = user.name;
        phoneNumber = user.noWa;
        address = user.alamat;
        
        _nameController.text = user.name;
        _phoneController.text = user.noWa ?? "";
        _addressController.text = user.alamat ?? "";
      });
    }
    
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      setState(() {
        _isLoading = true;
      });

      bool success = await _userService.updateUser(
        name: name!,
        noWa: phoneNumber!,
        alamat: address!,
        fotoProfil: _image,
      );

      setState(() {
        _isLoading = false;
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profil berhasil diperbarui")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal memperbarui profil")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

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
              onPressed: _submitForm,
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
      controller: _addressController,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Masukkan alamat Anda");
        }
        return null;
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
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Masukkan nomor WhatsApp");
        }
        return null;
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
      controller: _nameController,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Masukkan nama Anda");
        }
        return null;
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

