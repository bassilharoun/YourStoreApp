
import 'package:flutter/material.dart';
import 'package:shop_app/shop_app/shared/colors.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'Myfont',
    floatingActionButtonTheme:FloatingActionButtonThemeData(
        backgroundColor: defaultColor
    ),
    scaffoldBackgroundColor: Colors.black87,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: defaultColor),
      titleTextStyle: TextStyle(
          color: defaultColor,
          fontSize: 22,
          fontWeight: FontWeight.bold
      ),
      backgroundColor: Colors.black87,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        elevation: 20,
        backgroundColor: defaultColor
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white
        )
    )
) ;
ThemeData lightTheme = ThemeData(
    fontFamily: 'Myfont',
    floatingActionButtonTheme:FloatingActionButtonThemeData(
        backgroundColor: defaultColor
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: defaultColor),
      titleTextStyle: TextStyle(
          color: defaultColor,
          fontSize: 22,
          fontWeight: FontWeight.bold
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        elevation: 20
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.black87
        ),

    ),
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: defaultColor,
    suffixIconColor: defaultColor,
    focusColor: defaultColor,
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: defaultColor)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
  )

) ;