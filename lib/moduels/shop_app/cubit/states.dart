import 'package:test1/models/change_favorites.dart';
import 'package:test1/models/login_modle.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates {}
class ShopChangeBottomNavState extends ShopStates {}
class ShopLoadingHomeDataState extends ShopStates {}
class ShopSuccessHomeDataState extends ShopStates {}
class ShopErrorHomeDataState extends ShopStates {}
 class ShopLoadingCategoriesDataState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates {}
class ShopErrorCategoriesState extends ShopStates {}
class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates
{
  late final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates {}
class ShopLoadingGetFavoritesState extends ShopStates {}
class ShopSuccessGetFavoritesState extends ShopStates {}
class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingGetProfileState extends ShopStates {}
class ShopSuccessGetProfileState extends ShopStates
{
  final LoginModel loginModel;

  ShopSuccessGetProfileState(this.loginModel);
}
class ShopErrorGetProfileState extends ShopStates {}




