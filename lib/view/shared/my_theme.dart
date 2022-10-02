import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xFF5D9CEC);

  static const Color LightscaffoldBackGroundColor = Color(0xFFDFECDB);
  static const Color darkscaffoldBackGroundColor = Color(0xFF060E1E);

  static const Color red = Color(0xFFEC4B4B);

  static const Color green = Color(0xFF61E757);

  static final lightTheme = ThemeData(
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: LightscaffoldBackGroundColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(size: 35),
        unselectedIconTheme: IconThemeData(size: 35),
      ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
          color: lightPrimary, fontSize: 20, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(
          color: lightPrimary, fontSize: 18, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );
  static final darkTheme = ThemeData(
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: darkscaffoldBackGroundColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        // backgroundColor: darkscaffoldBackGroundColor,
        selectedIconTheme: IconThemeData(size: 35),
        unselectedIconTheme: IconThemeData(size: 35),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
            color: lightPrimary, fontSize: 20, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(
            color: lightPrimary, fontSize: 18, fontWeight: FontWeight.bold),
        bodySmall: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ));
}
