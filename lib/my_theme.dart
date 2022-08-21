import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xFF5D9CEC);

  static const Color LightscaffoldBackGroundColor = Color(0xFFDFECDB);

  static const Color red = Color(0xFFEC4B4B);

  static const Color green = Color(0xFF61E757);

  static final lightTheme = ThemeData(
    primaryColor: lightPrimary,
      scaffoldBackgroundColor: LightscaffoldBackGroundColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(size: 35),
        unselectedIconTheme: IconThemeData(size: 35),
      ),
      textTheme: TextTheme(
        titleMedium: TextStyle(
            color: lightPrimary, fontSize: 20, fontWeight: FontWeight.bold),
        bodySmall: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ));
}
