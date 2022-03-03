import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/models/categories_modele.dart';

import 'package:test1/models/home_model.dart';
import 'package:test1/models/login_modle.dart';
import 'package:test1/moduels/shop_app/cubit/states.dart';
import 'package:test1/moduels/shop_app/favortites/favorites_screen.dart';
import 'package:test1/moduels/shop_app/settings/settings_screen.dart';
import 'package:test1/shared/network/remote/dio_helper.dart';
import '../../../models/categories_modele.dart';
import '../../../models/change_favorites.dart';
import '../../../models/favorites_modele.dart';
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
  Map<int,bool>favorites={};
  void  getHomeData ()
    {
      emit(ShopLoadingHomeDataState());
      DioHelper.getData(
          url: HOME,
        token:token,
      ).then((value) {
        homeModel=HomeModel.fromJson(value.data);
        homeModel!.data!.products.forEach((element)
        {
          favorites.addAll({
            element.id!:element.inFavorites!,
          });
        });
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


  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId)
  {

      if(favorites[productId] == true)
      {
        favorites[productId] = false;
      }
      else {
        favorites[productId] = true;
      }

    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
      token: token,
      data: {'product_id': productId},
    ).then((value) {
      changeFavoritesModel =ChangeFavoritesModel.fromJson(value.data);
      if(changeFavoritesModel!.status==false)
        {
          if(favorites[productId] == true)
          {
            favorites[productId] = false;
          }
          else {
            favorites[productId] = true;
          } }
      else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((onError){


      emit(ShopErrorChangeFavoritesState());
    });
  }


  FavoritesModel? favoritesModel;
  void  getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token:token,
    ).then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  LoginModel? userModel;
  void  getUserData()
  {
    emit(ShopLoadingGetProfileState());
    DioHelper.getData(
      url: PROFILE,
      token:token,
    ).then((value) {
      userModel=LoginModel.fromJson(value.data!);
      print(userModel!.data!.name);
      emit(ShopSuccessGetProfileState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetProfileState());
    });
  }


}