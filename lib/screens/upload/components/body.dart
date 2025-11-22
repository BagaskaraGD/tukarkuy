import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tukarkuy/size_config.dart';
import 'package:tukarkuy/components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  String? productName;
  String? condition = 'Baru';
  String? description;
  String? stock;
  final List<String> conditions = ['Baru', 'Bekas'];

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: getProportionateScreenHeight(150),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Color(0xFFBDBDBD),
                        style: BorderStyle.solid, // Should be dotted but solid for now
                        width: 1,
                      ),
                    ),
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.file_upload_outlined,
                                size: 40,
                                color: Color(0xFFBDBDBD),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Tap untuk upload foto barang",
                                style: TextStyle(color: Color(0xFFBDBDBD)),
                              ),
                            ],
                          ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildProductNameFormField(),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      buildConditionDropdown(),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      buildDescriptionFormField(),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      buildStockFormField(),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      DefaultButton(
                        text: "Upload",
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // Implement upload logic
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Barang berhasil diupload (Simulasi)")),
                            );
                          }
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(30)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildStockFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => stock = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return "Masukkan stok barang";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Stok Barang",
        hintText: "Masukkan jumlah stok",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFBDBDBD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFBDBDBD)),
        ),
      ),
    );
  }

  TextFormField buildDescriptionFormField() {
    return TextFormField(
      maxLines: 3,
      onSaved: (newValue) => description = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return "Masukkan deskripsi barang";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Deskripsi",
        hintText: "Masukkan deskripsi barang",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFBDBDBD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFBDBDBD)),
        ),
      ),
    );
  }

  DropdownButtonFormField<String> buildConditionDropdown() {
    return DropdownButtonFormField<String>(
      value: condition,
      items: conditions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          condition = newValue!;
        });
      },
      decoration: InputDecoration(
        labelText: "Pilih Kondisi Barang",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFBDBDBD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFBDBDBD)),
        ),
      ),
    );
  }

  TextFormField buildProductNameFormField() {
    return TextFormField(
      onSaved: (newValue) => productName = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return "Masukkan nama barang";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Nama Barang",
        hintText: "Masukkan nama barang",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFBDBDBD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFBDBDBD)),
        ),
      ),
    );
  }
}
