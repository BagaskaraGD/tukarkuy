// lib/components/custom_bottom_navigation_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tukarkuy/screens/home/home_screen.dart';
import 'package:tukarkuy/screens/profile/profile_screen.dart';
import 'package:tukarkuy/screens/sign_in/sign_in_screen.dart'; // <-- Pastikan import ini ada
import 'package:tukarkuy/utils/token_storage.dart'; // <-- Pastikan import ini ada

import '../constants.dart';

enum Menu { home, favourites, message, profile }

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key, required this.selectedMenu})
    : super(key: key);

  final Menu selectedMenu;
  final Color inActiveColor = const Color(0xFFADADAD);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, -15),
            color: const Color(0xFFDADADA).withOpacity(.40),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Shop Icon.svg",
                // ignore: deprecated_member_use
                color: selectedMenu == Menu.home
                    ? kPrimaryColor
                    : inActiveColor,
              ),
              onPressed: () {
                // Navigasi ke Home jika belum di sana
                if (selectedMenu != Menu.home) {
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                }
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Heart Icon.svg",
                // ignore: deprecated_member_use
                color: selectedMenu == Menu.favourites
                    ? kPrimaryColor
                    : inActiveColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Chat bubble Icon.svg",
                // ignore: deprecated_member_use
                color: selectedMenu == Menu.message
                    ? kPrimaryColor
                    : inActiveColor,
              ),
              onPressed: () {},
            ),
            // =======================================================
            // === DI SINILAH LOKASI PERUBAHAN UTAMANYA ===
            // =======================================================
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/User Icon.svg",
                // ignore: deprecated_member_use
                color: selectedMenu == Menu.profile
                    ? kPrimaryColor
                    : inActiveColor,
              ),
              onPressed: () async {
                // 1. Jadikan fungsi ini async
                // Jangan lakukan apa-apa jika sudah di halaman profile
                if (selectedMenu == Menu.profile) return;

                // 2. Buat instance TokenStorage dan cek tokennya
                final tokenStorage = TokenStorage();
                final token = await tokenStorage.getToken();

                if (token != null) {
                  // 3. Jika ADA token (sudah login), arahkan ke ProfileScreen
                  Navigator.pushNamed(context, ProfileScreen.routeName);
                } else {
                  // 4. Jika TIDAK ADA token (tamu), arahkan ke SignInScreen
                  Navigator.pushNamed(context, SignInScreen.routeName);
                }
              },
            ),
            // =======================================================
            // === AKHIR DARI PERUBAHAN ===
            // =======================================================
          ],
        ),
      ),
    );
  }
}
