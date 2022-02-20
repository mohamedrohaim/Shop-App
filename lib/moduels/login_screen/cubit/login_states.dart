
import '../../../models/login_modle.dart';

abstract class ShopLoginStates{}
class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates
{
  late LoginModel? loginModel;
  ShopLoginSuccessState({this.loginModel});
}
class ShopLoginErrorState extends ShopLoginStates{
  late final String error;
  ShopLoginErrorState({required this.error});
}
class ShopChangePasswordVisibilityState extends ShopLoginStates{}