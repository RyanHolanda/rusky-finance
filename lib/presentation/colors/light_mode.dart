import 'package:flutter/material.dart';

ThemeData lightmode() {
  return ThemeData(
      secondaryHeaderColor: Colors.white,
      primaryColor: Colors.black,
      brightness: Brightness.light,
      cardColor: Colors.white,
      buttonTheme: const ButtonThemeData(buttonColor: Colors.white),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black)));
}
