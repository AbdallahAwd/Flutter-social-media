import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.green,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.black, size: 20.0),
    actionsIconTheme: IconThemeData(color: Colors.black, size: 20.0),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: defaultHexColor, systemNavigationBarColor: Colors.white),
    titleSpacing: 20.0,
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 30.0,
    selectedItemColor: Colors.orange,
    unselectedItemColor: Colors.black,
  ),

  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    bodyText2: TextStyle(
      fontSize: 15.0,
      color: Colors.black,
      height: 1.4

    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.amber,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 30.0,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.black),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white, size: 20.0),
    backgroundColor: Colors.black38,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
    ),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 20.0),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.orange,
    ),
    titleSpacing: 20.0,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    bodyText2: TextStyle(
      fontSize: 12.0,
      color: Colors.grey,
      fontWeight: FontWeight.w600,
    ),
  ),
  scaffoldBackgroundColor: Colors.black38,
);

var uId;
bool OTB;
var defaultHexColor = HexColor('#29A68D');
