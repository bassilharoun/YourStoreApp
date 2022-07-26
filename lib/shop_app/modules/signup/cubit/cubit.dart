import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app/models/login_model.dart';
import 'package:shop_app/shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shop_app/modules/signup/cubit/states.dart';
import 'package:shop_app/shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shop_app/shared/network/end_points.dart';

class ShopSignupCubit extends Cubit<ShopSignupStates>{
  ShopSignupCubit() : super(ShopSignupInitialState());

  static ShopSignupCubit get(context) => BlocProvider.of(context);

  LoginModel? signupModel ;

  void userSignup({
    required String email ,
    required String name ,
    required String phone ,
    required String password
}){
    emit(ShopSignupLoadingState());
    DioHelper.postData(
        url: SIGNUP,
        data: {
      'name' : name,
      'email' : email,
      'phone' : phone,
          'password' :password
        }).then((value) {
          signupModel = LoginModel.fromJson(value.data);
          print(signupModel!.message);
          print(signupModel!.data!.name);
          emit(ShopSignupSuccessState(signupModel!));
    }).catchError((error){
      emit(ShopSignupSuccessState(signupModel!));
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined ;
  bool isPassword = true ;

  void changePasswordVisibility(){
    isPassword = !isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
   emit(ShopChangePasswordVisibilitySignupState());
  }
}