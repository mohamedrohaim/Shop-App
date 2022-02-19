import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant.dart';
ThemeData darkTheme=  ThemeData(primarySwatch: defaultColor,scaffoldBackgroundColor: Colors.black12,
    floatingActionButtonTheme:  const FloatingActionButtonThemeData(
        backgroundColor:  defaultColor
    ),
    appBarTheme:const AppBarTheme(
      titleSpacing: 20.0,
      iconTheme: IconThemeData(color: Colors.white,),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black12,
        statusBarIconBrightness:Brightness.light,
      ),
      backgroundColor: Colors.black12,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
      type:  BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.white,
      elevation: 20.0,
      backgroundColor: Colors.black12,
    ),
    textTheme:  const TextTheme(
      bodyText1: TextStyle( fontSize: 18.0,fontWeight: FontWeight.w600,color: Colors.white),
    ),
    fontFamily: 'Jannah');


ThemeData lightTheme=ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:  const AppBarTheme(

      titleSpacing: 20.0,
      iconTheme: IconThemeData(color: Colors.black,),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness:Brightness.dark,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ), bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  type:  BottomNavigationBarType.fixed,
  selectedItemColor: defaultColor,
  unselectedItemColor: Colors.black,
  elevation: 20.0,
  backgroundColor: Colors.white,
),textTheme: const TextTheme(
  bodyText1: TextStyle( fontSize: 18.0,fontWeight: FontWeight.w600,color: Colors.black),
),
    fontFamily: 'Jannah');