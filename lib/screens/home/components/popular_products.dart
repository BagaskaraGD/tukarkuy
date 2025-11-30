import 'package:flutter/material.dart';

import './section_title.dart';
import '../../../size_config.dart';
import '../../../services/barang_service.dart';
import '../../../models/barang.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({
    super.key,
    required this.searchQuery,
    this.title = "Rekomendasi Barang",
    this.showHeader = true,
    this.maxItems,
    this.categoryId,
  });

  final String searchQuery;
  final String title;
  final bool showHeader;
  final int? maxItems;
  final int? categoryId;

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  final BarangService _barangService = BarangService();
  late Future<List<Barang>> _futureBarang;

  @override
  void initState() {
    super.initState();
    _futureBarang = _barangService.fetchBarangList(
      categoryId: widget.categoryId,
    );
  }

  @override
  void didUpdateWidget(covariant PopularProducts oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryId != widget.categoryId) {
      setState(() {
        _futureBarang = _barangService.fetchBarangList(
          categoryId: widget.categoryId,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = widget.searchQuery.toLowerCase().trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showHeader) ...[
          SectionTitle(title: widget.title, press: () {}),
          SizedBox(height: getProportionateScreenHeight(14)),
        ],
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: FutureBuilder<List<Barang>>(
            future: _futureBarang,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding:
                      EdgeInsets.only(top: getProportionateScreenHeight(20)),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError) {
                return Padding(
                  padding:
                      EdgeInsets.only(top: getProportionateScreenHeight(10)),
                  child: Text(
                    "Gagal memuat barang",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                );
              }

              final items = snapshot.data ?? [];

              // Filter by category if provided (safeguard when backend ignores query).
              final byCategory = widget.categoryId == null
                  ? items
                  : items
                      .where((item) => item.categoryId == widget.categoryId)
                      .toList();

              // Apply search filter.
              final filtered = query.isEmpty
                  ? byCategory
                  : byCategory
                      .where((item) =>
                          item.nama.toLowerCase().contains(query) ||
                          item.deskripsi?.toLowerCase().contains(query) ==
                              true)
                      .toList();

              final limited = widget.maxItems != null
                  ? filtered.take(widget.maxItems!).toList()
                  : filtered;

              if (limited.isEmpty) {
                return Padding(
                  padding:
                      EdgeInsets.only(top: getProportionateScreenHeight(10)),
                  child: Text(
                    query.isEmpty
                        ? "Belum ada barang."
                        : "Tidak ada barang yang cocok.",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: getProportionateScreenHeight(14),
                  crossAxisSpacing: getProportionateScreenWidth(14),
                  childAspectRatio: .78,
                ),
                itemCount: limited.length,
                itemBuilder: (context, index) {
                  final item = limited[index];
                  final imageUrl = _barangService.buildImageUrl(item.fotoPath);
                  return RecommendationCard(
                    title: item.nama,
                    condition: item.kondisi,
                    imageUrl: imageUrl,
                  );
                },
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
    super.key,
    required this.title,
    required this.condition,
    required this.imageUrl,
  });

  final String title;
  final String condition;
  final String? imageUrl;

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
            child: imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _placeholderIcon(),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return _placeholderIcon();
                      },
                    ),
                  )
                : _placeholderIcon(),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: getProportionateScreenWidth(13),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: getProportionateScreenHeight(4)),
          Text(
            condition.isNotEmpty ? condition : "Kondisi tidak diketahui",
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

  Widget _placeholderIcon() {
    return Icon(
      Icons.image_outlined,
      color: Colors.grey.shade400,
      size: getProportionateScreenWidth(28),
    );
  }
}
