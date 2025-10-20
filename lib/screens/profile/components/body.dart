import 'package:flutter/material.dart';
import 'package:tukarkuy/screens/home/home_screen.dart'; // <-- IMPORT BARU
import 'package:tukarkuy/services/auth_service.dart'; // <-- IMPORT BARU
import './profile_picture.dart';
import '../../../size_config.dart';
import './profile_section_bar.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(40)),
          ProfilePicture(),
          SizedBox(height: getProportionateScreenHeight(60)),
          ProfileSectionButton(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () {},
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          ProfileSectionButton(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          ProfileSectionButton(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          ProfileSectionButton(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          ProfileSectionButton(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              try {
                // 2. Panggil fungsi logout dari AuthService
                await authService.logout();

                // 3. Arahkan pengguna kembali ke HomeScreen dan hapus semua rute sebelumnya
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HomeScreen.routeName, // Arahkan ke Halaman Utama
                  (Route<dynamic> route) =>
                      false, // Hapus semua rute di belakangnya
                );
              } catch (e) {
                // Tampilkan pesan error jika logout gagal (opsional)
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Gagal logout: $e")));
              }
            },
          ),
        ],
      ),
    );
  }
}
