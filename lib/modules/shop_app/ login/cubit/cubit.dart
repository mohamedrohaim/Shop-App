import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/modules/shop_app/%20login/cubit/states.dart';
import 'package:test1/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/end_point.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
 {
   ShopLoginCubit(): super(ShopLoginInitialState());
   static ShopLoginCubit get(context)=>BlocProvider.of(context);

   void userLogin({
   required String email,
     required String password,
 })
   {
     emit(ShopLoginLoadingState());
     DioHelper.postData(url: LOGIN,
         data: {'email':email,'password':password,},
     ).then((value) {
       if (kDebugMode) {
         print(value);
       }
       emit(ShopLoginSuccessState());
     }).catchError((error){
       emit(ShopLoginErrorState(error.toString()));
     });

   }

 }