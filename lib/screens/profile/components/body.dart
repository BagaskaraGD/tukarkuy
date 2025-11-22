import 'package:flutter/material.dart';
import 'package:tukarkuy/screens/home/home_screen.dart'; // <-- IMPORT BARU
import 'package:tukarkuy/services/auth_service.dart'; // <-- IMPORT BARU
import './profile_picture.dart';
import './profile_edit.dart';
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
            text: "Ubah Profil",
            icon: "assets/icons/User Icon.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileEditScreen()),
              );
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          ProfileSectionButton(
            text: "Notifikasi",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          ProfileSectionButton(
            text: "Tentang TukarKuy",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          ProfileSectionButton(
            text: "Keluar",
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
