import 'package:shop_app/shop_app/models/login_model.dart';

abstract class ShopSignupStates {}

class ShopSignupInitialState extends ShopSignupStates {}
class ShopSignupLoadingState extends ShopSignupStates {}
class ShopSignupSuccessState extends ShopSignupStates {
  final LoginModel signupModel ;

  ShopSignupSuccessState(this.signupModel);
}
class ShopSignupErrorState extends ShopSignupStates {
  final String error ;
  ShopSignupErrorState(this.error);
}

class ShopChangePasswordVisibilitySignupState extends ShopSignupStates {}