import 'package:flutter/material.dart';

import './components/body.dart';
import '../../models/Product.dart';
import './components/custom_appbar.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';

  // Perbaikan 1: Tambahkan konstruktor modern
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Perbaikan 2: Lakukan null check dan type casting pada argumen
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      // Perbaikan 3: Sesuaikan dengan konstruktor CustomAppBar yang baru
      appBar: CustomAppBar(rating: product.rating),
      body: Body(product: product),
    );
  }
}
