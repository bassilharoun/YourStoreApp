import 'package:shop_app/shop_app/models/change_fav_model.dart';
import 'package:shop_app/shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}

class ShopLoadingCategoriesState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}

class ShopSuccessChangeFavState extends ShopStates{

  final ChangeFavModel model ;

  ShopSuccessChangeFavState(this.model);
}
class ShopErrorChangeFavState extends ShopStates{}

class ShopChangeFavState extends ShopStates{}

class ShopSuccessGetFavState extends ShopStates{}
class ShopErrorGetFavState extends ShopStates{}
class ShopLoadingGetFavState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{
  final LoginModel model ;

  ShopSuccessUserDataState(this.model);
}
class ShopErrorUserDataState extends ShopStates{}
class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUpdateUserDataState extends ShopStates{
  final LoginModel model ;

  ShopSuccessUpdateUserDataState(this.model);
}
class ShopErrorUpdateUserDataState extends ShopStates{}
class ShopLoadingUpdateUserDataState extends ShopStates{}