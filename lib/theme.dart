import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import ini

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Muli',
    appBarTheme: appBarTheme(),
    textTheme: textTheme(), // Ganti nama fungsi agar tidak bentrok
    inputDecorationTheme: inputDecorationTheme(),
    primarySwatch: Colors.blue,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(24),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 6,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
    border: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
  );
}

TextTheme textTheme() {
  // Ganti nama fungsi
  return TextTheme(
    bodyLarge: TextStyle(color: kTextColor), // Ganti dari bodyText1
    bodyMedium: TextStyle(color: kTextColor), // Ganti dari bodyText2
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light, // Ganti dari brightness
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      // Ganti dari textTheme
      color: Color(0xFF8b8b8b),
      fontSize: 18,
    ),
  );
}
