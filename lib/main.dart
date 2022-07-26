import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app/app_cubit/app_cubit.dart';
import 'package:shop_app/shop_app/app_cubit/app_states.dart';
import 'package:shop_app/shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shop_app/layout/shop_layout.dart';
import 'package:shop_app/shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shop_app/styles/themes.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token');
  Widget widget ;
  token = CacheHelper.getData(key: 'token');
  print(token);

  if(onBoarding != null){
    if(token != null) widget = ShopLayout();
    else widget = LoginScreen();
  }else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget{

  final Widget? startWidget ;
  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit(),),
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavData()..getUserData(),)
      ],
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }

}
