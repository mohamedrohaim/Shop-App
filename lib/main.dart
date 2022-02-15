import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test1/shared/style/bloc_observer.dart';
import 'package:test1/shared/themes.dart';
import 'modules/shop_app/on_boarding_screen.dart';

void main() {
  BlocOverrides.runZoned(
        () {
          runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );

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
