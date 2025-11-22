import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tukarkuy/screens/home/home_screen.dart';
import 'package:tukarkuy/screens/profile/profile_screen.dart';
import 'package:tukarkuy/screens/sign_in/sign_in_screen.dart';
import 'package:tukarkuy/screens/upload/upload_screen.dart'; // New Import
import 'package:tukarkuy/utils/token_storage.dart';

import '../constants.dart';

enum Menu { home, upload, profile }

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
                if (selectedMenu != Menu.home) {
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                }
              },
            ),
            IconButton(
              icon: Icon(
                Icons.file_upload_outlined,
                color: selectedMenu == Menu.upload
                    ? kPrimaryColor
                    : inActiveColor,
                size: 28,
              ),
              onPressed: () async {
                 if (selectedMenu == Menu.upload) return;

                final tokenStorage = TokenStorage();
                final token = await tokenStorage.getToken();

                if (token != null) {
                  Navigator.pushNamed(context, UploadScreen.routeName);
                } else {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                }
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/User Icon.svg",
                // ignore: deprecated_member_use
                color: selectedMenu == Menu.profile
                    ? kPrimaryColor
                    : inActiveColor,
              ),
              onPressed: () async {
                if (selectedMenu == Menu.profile) return;

                final tokenStorage = TokenStorage();
                final token = await tokenStorage.getToken();

                if (token != null) {
                  Navigator.pushNamed(context, ProfileScreen.routeName);
                } else {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
