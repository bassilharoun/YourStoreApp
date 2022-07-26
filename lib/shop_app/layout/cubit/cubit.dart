import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app/layout/cubit/states.dart';
import 'package:shop_app/shop_app/models/categories_model.dart';
import 'package:shop_app/shop_app/models/change_fav_model.dart';
import 'package:shop_app/shop_app/models/fav_model.dart';
import 'package:shop_app/shop_app/models/home_model.dart';
import 'package:shop_app/shop_app/models/login_model.dart';
import 'package:shop_app/shop_app/modules/cateogries/cateogries_screen.dart';
import 'package:shop_app/shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/shop_app/modules/products/products_screen.dart';
import 'package:shop_app/shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shop_app/shared/components/constants.dart';
import 'package:shop_app/shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shop_app/shared/network/end_points.dart';
import 'package:shop_app/shop_app/shared/network/local/cache_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index){
    currentIndex = index ;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel ;


  void getHomeData(){
    token = CacheHelper.getData(key: 'token');
    emit(ShopLoadingHomeDataState());
    
    DioHelper.getData(
        url: HOME,
        token: token
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel!.data!.banners[0].image);
      // print(homeModel!.status);
      homeModel!.data!.products.forEach((element) {
        fav.addAll({
          element.id! : element.inFavorites!
        });
      });
      // print(fav.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel ;

  void getCategoriesData(){
    DioHelper.getData(
        url: CATEGORIES,
        token: token
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  Map<int , bool> fav= {};
  ChangeFavModel? changeFavModel ;

  void changeFav(int productId){
    if(fav[productId] == true )
    {
      fav[productId] = false;
    } else {
      fav[productId] = true;
    }
    emit(ShopChangeFavState());



    DioHelper.postData(
        url: FAV,
        data: {
          'product_id' : productId
        },
        token: token
    ).then((value) {
      changeFavModel = ChangeFavModel.fromJson(value.data);
      print(value.data);
      if(changeFavModel!.status == false ){
        if(fav[productId] == true )
        {
          fav[productId] = false;
        } else {
          fav[productId] = true;
        }
      }else {
        getFavData();
      }
    emit(ShopSuccessChangeFavState(changeFavModel!));

    }).catchError((error){
      if(fav[productId] == true )
      {
        fav[productId] = false;
      } else {
        fav[productId] = true;
      }
      emit(ShopErrorChangeFavState());
    });
  }

  FavModel? favModel ;

  void getFavData(){
    emit(ShopLoadingGetFavState());
    DioHelper.getData(
        url: FAV,
        token: token
    ).then((value) {
      favModel = FavModel.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessGetFavState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavState());
    });
  }

  LoginModel? userModel ;

  void getUserData(){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      // print(userModel!.data!.name);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
  required String name ,
    required String email ,
    required String phone ,
}){
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
      data: {
          'name' : name,
        'email' : email ,
        'phone' : phone
      }
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      // print(userModel!.data!.name);
      emit(ShopSuccessUpdateUserDataState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }



}