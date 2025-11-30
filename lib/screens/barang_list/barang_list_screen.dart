import 'package:flutter/material.dart';

import './components/body.dart';

class BarangListScreen extends StatelessWidget {
  static const routeName = '/barang-list';

  const BarangListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final int? categoryId = args != null ? args['categoryId'] as int? : null;
    final String? categoryName =
        args != null ? args['categoryName'] as String? : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName ?? "Barang"),
        elevation: 0,
      ),
      body: BarangListBody(
        categoryId: categoryId,
        categoryName: categoryName,
      ),
    );
  }
}
