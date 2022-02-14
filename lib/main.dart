import 'package:flutter/material.dart';
import 'package:test1/shared/themes.dart';
import 'modules/shop_app/on_boarding_screen.dart';

void main() {
  runApp(MyApp());

}
class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode:ThemeMode.light,
      home: OnBoardingScreen(),
    );
  }

}
