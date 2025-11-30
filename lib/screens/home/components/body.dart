import 'package:flutter/material.dart';

import './home_header.dart';
import './discount_banner.dart';
import '../../../size_config.dart';
import '../../barang_list/barang_list_screen.dart';
import './section_title.dart';
import './popular_products.dart';
import './categories.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(18),
          ),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(8)),
              HomeHeader(
                onSearchChanged: (value) {},
                searchReadOnly: true,
                onSearchTap: () =>
                    Navigator.pushNamed(context, BarangListScreen.routeName),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              DiscountBanner(),
              SizedBox(height: getProportionateScreenHeight(22)),
              Categories(),
              SizedBox(height: getProportionateScreenHeight(22)),
              SectionTitle(
                title: "Rekomendasi Barang",
                press: () =>
                    Navigator.pushNamed(context, BarangListScreen.routeName),
              ),
              SizedBox(height: getProportionateScreenHeight(12)),
              PopularProducts(searchQuery: '', showHeader: false, maxItems: 4),
              SizedBox(height: getProportionateScreenHeight(20)),
            ],
          ),
        ),
      ),
    );
  }
}
