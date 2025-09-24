import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../models/Product.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key, // Perbaikan: Gunakan super.key
    required this.product,
    required this.pressOnSeeMore,
  });

  final Product product;
  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: Text(
            product.title,
            // PERBAIKAN 1: Ganti headline6 menjadi titleLarge
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: getProportionateScreenWidth(64),
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            decoration: BoxDecoration(
              color: product.isFavourite
                  ? kPrimaryColor.withOpacity(.17)
                  : kSecondaryColor.withOpacity(.12),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
            ),
            child: SvgPicture.asset(
              product.isFavourite
                  ? "assets/icons/Heart Icon_2.svg"
                  : "assets/icons/Heart Icon.svg",
              // PERBAIKAN 2: Ganti 'color' menjadi 'colorFilter'
              colorFilter: ColorFilter.mode(
                product.isFavourite
                    ? const Color(0xFFFF4848).withOpacity(.9)
                    : const Color(0xFFDBDEE4),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(product.description, maxLines: 3),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 5,
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(20),
          ),
          child: TextButton(
            onPressed: pressOnSeeMore,
            child: const Row(
              children: [
                Text("See More Details"),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward_ios, size: 12),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
