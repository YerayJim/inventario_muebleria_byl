import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Colors.black,
  textTheme: TextTheme(
    headline4: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.black,
    ),
  ),
);
