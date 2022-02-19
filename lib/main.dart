import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test1/shared/bloc_observer.dart';
import 'package:test1/shared/network/local/shared_prefrences.dart';
import 'package:test1/shared/network/remote/dio_helper.dart';
import 'package:test1/shared/style/theme.dart';
import 'moduels/login_screen/login_screen.dart';
import 'moduels/on_boarding_screen/on_boarding.dart';

// void main() {
//   runApp(const MyApp());
// }
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        ()async {
          DioHelper.init();
         await CacheHelper.init();
          dynamic onBoarding=CacheHelper.getData(key: 'onBoarding');
          print(onBoarding);
     runApp( MyApp(onBoarding:onBoarding ,));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const   MyApp({Key? key,this.onBoarding }) : super(key: key);
final onBoarding;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: onBoarding==true?ShopLoginScreen():const OnBoardingScreen(),
    );
  }
}

