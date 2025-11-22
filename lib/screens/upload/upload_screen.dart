import 'package:flutter/material.dart';
import 'package:tukarkuy/components/custom_bottom_navigation_bar.dart';
import 'package:tukarkuy/size_config.dart';
import 'components/body.dart';

class UploadScreen extends StatelessWidget {
  static const routeName = "/upload";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Barang"),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavigationBar(selectedMenu: Menu.upload),
    );
  }
}
