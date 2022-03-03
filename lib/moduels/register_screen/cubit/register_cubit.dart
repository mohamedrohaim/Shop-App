import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/moduels/login_screen/cubit/login_states.dart';
import 'package:test1/moduels/register_screen/cubit/register_states.dart';

import '../../../models/login_modle.dart';
import '../../../shared/network/endpoints.dart';
import '../../../shared/network/remote/dio_helper.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{


  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context, )=>BlocProvider.of(context);
  LoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data:
      {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value)
    {
      loginModel=LoginModel.fromJson(value.data);
      print(value.data);
      emit(ShopRegisterSuccessState(loginModel: loginModel));
    }).catchError((error)
    {
      print(error.toString());

      emit(ShopRegisterErrorState (error:error.toString()));
    });
  }

IconData suffix=Icons.visibility_outlined;
bool isPassword=true;
void changePasswordVisibility()
{
  isPassword=!isPassword;
  suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
emit(ShopChangePasswordRegisterVisibilityState());
}
}
