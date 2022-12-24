import 'package:flutter/material.dart';

ThemeData darkmode() {
  return ThemeData(
    secondaryHeaderColor: Colors.black,
    primaryColor: Colors.white,
    cardColor: Colors.white.withOpacity(0.03),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.white.withOpacity(0.05),
    ),
    brightness: Brightness.dark,
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.black),
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 7, 7, 7),
        elevation: 0),
    scaffoldBackgroundColor: const Color.fromARGB(255, 7, 7, 7),
  );
}
