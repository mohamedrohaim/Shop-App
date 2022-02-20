import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/moduels/shop_app/cubit/states.dart';
import 'package:test1/moduels/shop_app/favortites/favorites_screen.dart';
import 'package:test1/moduels/shop_app/settings/settings_screen.dart';
import '../categories/categories_screen.dart';
import '../products/products_screen.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
  List<Widget>bottomScreens=
  [
    productsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void ChangeBottom(int index)
  {
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }



}