import 'package:flutter/material.dart';
import 'package:jasamarga_nde_flutter/resources/resources.dart';

class SMTheme {
  static ThemeData buildThemeData() {
    return ThemeData(
      primaryColor: Resources.color.colorPrimary,
      accentColor: Resources.color.colorAccent,
      fontFamily: 'Roboto',
      floatingActionButtonTheme: FloatingActionButtonThemeData(),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
            color: Colors.red), // Navbar
        headline2: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white), // Banner
        headline3: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.black), // Normal
        headline4: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black),
        headline5: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.black54), // SubNormal
        headline6: TextStyle(
            fontSize: 16.0, color: Colors.red, fontWeight: FontWeight.w500),
        bodyText1: TextStyle(fontSize: 14.0, color: Colors.black87),
        bodyText2: TextStyle(fontSize: 14.0, color: Colors.black87),
      ),
    );
  }
}
