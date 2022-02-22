
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/models/categories_modele.dart';

import 'package:test1/models/home_model.dart';
import 'package:test1/moduels/shop_app/cubit/states.dart';
import 'package:test1/moduels/shop_app/favortites/favorites_screen.dart';
import 'package:test1/moduels/shop_app/settings/settings_screen.dart';
import 'package:test1/shared/network/remote/dio_helper.dart';
import '../../../models/categories_modele.dart';
import '../../../shared/constant.dart';
import '../../../shared/network/endpoints.dart';
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
  HomeModel? homeModel;
  void  getHomeData ()
    {
      emit(ShopLoadingHomeDataState());
      DioHelper.getData(
          url: HOME,
        token:token,
      ).then((value) {
        homeModel=HomeModel.fromJson(value.data);
        print(homeModel!.data!.banners[0].image);
       emit(ShopSuccessHomeDataState());
      }).catchError((error){
        print(error.toString());
        emit(ShopErrorHomeDataState());
      });
    }
  CategoriesModel? categoriesModel;
  void  getCategories()
  {
    emit(ShopLoadingCategoriesDataState());
    DioHelper.getData(
      url: GET_CATEGORIES,
      token:token,
    ).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

}