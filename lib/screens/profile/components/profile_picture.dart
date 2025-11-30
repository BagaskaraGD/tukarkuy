import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key, this.imageFile, this.onImageSelect});

  final File? imageFile;
  final VoidCallback? onImageSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // klik di mana saja di area foto -> ganti foto
      onTap: onImageSelect,
      child: SizedBox(
        height: getProportionateScreenWidth(115),
        width: getProportionateScreenWidth(115),
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              backgroundImage: imageFile != null
                  ? FileImage(imageFile!) as ImageProvider
                  : const AssetImage("assets/images/Profile Image.png"),
            ),
            if (onImageSelect != null)
              Positioned(
                right: -16,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color: Colors.white),
                      ),
                      backgroundColor: const Color(0xFFF5F6F9),
                    ),
                    onPressed: onImageSelect,
                    child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
