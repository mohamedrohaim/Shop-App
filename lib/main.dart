import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/moduels/shop_app/cubit/states.dart';
import 'package:test1/shared/bloc_observer.dart';
import 'package:test1/shared/constant.dart';
import 'package:test1/shared/network/local/shared_prefrences.dart';
import 'package:test1/shared/network/remote/dio_helper.dart';
import 'package:test1/shared/style/theme.dart';
import 'moduels/login_screen/login_screen.dart';
import 'moduels/on_boarding_screen/on_boarding.dart';
import 'moduels/shop_app/cubit/cubit.dart';
import 'moduels/shop_app/shop_layout_screen.dart';

// void main() {
//   runApp(const MyApp());
// }
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        ()async {
          DioHelper.init();
         await CacheHelper.init();

         Widget widget;
           bool? onBoarding=CacheHelper.getData(key: 'onBoarding') ;
          token=CacheHelper.getData(key: 'token');

          if(onBoarding!=null)
          {
            if(token!=null)
            {
              widget=ShopLayout();
            }
            else
            {
              widget=ShopLoginScreen();
            }
          }else
          {
            widget=OnBoardingScreen();
          }

          print(onBoarding);
     runApp( MyApp(startWidget:widget ,));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const   MyApp({this.onBoarding,this.startWidget });
final  onBoarding;
final Widget? startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=>ShopCubit()..getCategories()..getHomeData()..getFavorites()..getUserData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state)
        {
        },
      builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
      },
      ),
      );
  }
}

