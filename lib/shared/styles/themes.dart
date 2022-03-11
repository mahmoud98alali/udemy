import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'Jannha',
  textTheme:const TextTheme(
    bodyText1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16.0
    ),
  ) ,
  primarySwatch: Colors.blue,

  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    titleTextStyle: TextStyle(
        fontFamily: 'Jannha',
        color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
    color: Colors.black,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor, //for NewsApp
      elevation: 20.0,
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.white
  ),

  // primarySwatch: Colors.red,
);
ThemeData lightTheme = ThemeData(
  fontFamily: 'Jannha',
  textTheme:const TextTheme(
    bodyText1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16.0
    ),
  ) ,
  primarySwatch: Colors.blue,

  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    titleTextStyle: TextStyle(
        fontFamily: 'Jannha',
        color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    color: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 20.0,
      backgroundColor: Colors.white
  ),
  // primarySwatch: Colors.red,
);