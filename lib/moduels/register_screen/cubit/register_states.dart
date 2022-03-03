
import '../../../models/login_modle.dart';

abstract class ShopRegisterStates{}
class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates
{
  late LoginModel? loginModel;
  ShopRegisterSuccessState({this.loginModel});
}
class ShopRegisterErrorState extends ShopRegisterStates{
  late final String error;
  ShopRegisterErrorState({required this.error});
}
class ShopChangePasswordRegisterVisibilityState extends ShopRegisterStates{}