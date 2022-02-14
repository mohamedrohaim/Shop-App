abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates{}

class ShopLoginErrorState extends ShopLoginStates
{
  late final String error;

  ShopLoginErrorState(String error);
}