import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../home/components/search_field.dart';
import '../../home/components/popular_products.dart';

class BarangListBody extends StatefulWidget {
  const BarangListBody({super.key, this.categoryId, this.categoryName});

  final int? categoryId;
  final String? categoryName;

  @override
  State<BarangListBody> createState() => _BarangListBodyState();
}

class _BarangListBodyState extends State<BarangListBody> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(16),
          ),
          child: Column(
            children: [
              SearchField(
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              PopularProducts(
                searchQuery: _searchQuery,
                showHeader: false,
                categoryId: widget.categoryId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
