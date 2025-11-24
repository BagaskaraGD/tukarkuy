import 'package:flutter/material.dart';

import './section_title.dart';
import '../../../size_config.dart';

const List<Map<String, String>> _recommendedItems = [
  {"title": "Helm Sepeda", "condition": "Bekas - Kondisi Baik"},
  {"title": "Stick PS4", "condition": "Bekas - Kondisi Baik"},
  {"title": "Helm Sepeda", "condition": "Bekas - Kondisi Baik"},
  {"title": "Stick PS4", "condition": "Bekas - Kondisi Baik"},
];

class PopularProducts extends StatelessWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: "Rekomendasi Barang", press: () {}),
        SizedBox(height: getProportionateScreenHeight(14)),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: getProportionateScreenHeight(14),
              crossAxisSpacing: getProportionateScreenWidth(14),
              childAspectRatio: .9,
            ),
            itemCount: _recommendedItems.length,
            itemBuilder: (context, index) {
              final item = _recommendedItems[index];
              return RecommendationCard(
                title: item['title'] ?? '',
                condition: item['condition'] ?? '',
              );
            },
          ),
        ),
      ],
    );
  }
}

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    Key? key,
    required this.title,
    required this.condition,
  }) : super(key: key);

  final String title;
  final String condition;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      padding: EdgeInsets.all(getProportionateScreenWidth(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: getProportionateScreenHeight(90),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6FA),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Icon(
              Icons.image_outlined,
              color: Colors.grey.shade400,
              size: getProportionateScreenWidth(28),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: getProportionateScreenWidth(14),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: getProportionateScreenHeight(4)),
          Text(
            condition,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: getProportionateScreenWidth(12),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
