import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/moduels/login_screen/cubit/state.dart';

import '../../../models/login_modle.dart';
import '../../../shared/network/endpoints.dart';
import '../../../shared/network/remote/dio_helper.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates>
{


  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context, )=>BlocProvider.of(context);
  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email': email,
        'password': password,
      },
    ).then((value)
    {
      loginModel=LoginModel.fromJson(value.data);
      print(value.data);
      emit(ShopLoginSuccessState(loginModel: loginModel));

    }).catchError((error)
    {
      print(error.toString());

      emit(ShopLoginErrorState (error:error.toString()));
    });
  }

IconData suffix=Icons.visibility_outlined;
bool isPassword=true;
void changePasswordVisibility()
{
  isPassword=!isPassword;
  suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
  emit(ShopChangePasswordVisibilityState());
}
}
