import 'package:flutter/material.dart';
import 'package:tukarkuy/constants.dart';

import '../../../size_config.dart';

// ignore: must_be_immutable
class Categories extends StatelessWidget {
  List<Map<String, dynamic>> categories = [
    {
      "icon": Icons.electrical_services,
      "text": "Elektronik",
      "id": 1,
    },
    {
      "icon": Icons.home_filled,
      "text": "Alat Rumah Tangga",
      "id": 2,
    },
    {
      "icon": Icons.toys,
      "text": "Hobi & Mainan",
      "id": 3,
    },
    {
      "icon": Icons.checkroom,
      "text": "Fashion",
      "id": 4,
    },
    {
      "icon": Icons.shopping_basket,
      "text": "Kebutuhan Harian",
      "id": 5,
    },
  ];

  Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            categories.length,
            (index) => CategoryCard(
              icon: categories[index]['icon'],
              text: categories[index]['text'],
              press: () {
                Navigator.pushNamed(
                  context,
                  '/barang-list',
                  arguments: {
                    'categoryId': categories[index]['id'],
                    'categoryName': categories[index]['text'],
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.icon,
    required this.text,
    required this.press,
  });

  final IconData icon;
  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFDFECFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: kPrimaryColor.withOpacity(.8),
                  size: getProportionateScreenWidth(22),
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
