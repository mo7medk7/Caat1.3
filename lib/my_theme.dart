import 'dart:ui';

import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLightColor = Color(0xff3498DB);
  static Color yelloColor = Color(0xffF39C12);
  static Color whiteColor = Color(0xffFFFFFF);
  static Color primaryDarkColor = Color(0xff383838);
  static Color greyColor = Color(0xff707070);
  static Color custom_green = Color(0xff18DAA3);
  static Color backgroundColors = Colors.grey.shade100;
  static Color redColor = Color(0xFFFE4A49);
  static Color blueTask = Color(0xffBAE2F3);
  static Color yelloTask = Color(0xffffff00);
  static Color blueColor = Color(0xff3498DB);
  static Color blackColor = Color(0xff383838);


  static ThemeData lightTheme = ThemeData(
      primaryColor: primaryLightColor,
      scaffoldBackgroundColor: whiteColor,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryLightColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: yelloColor,
          unselectedItemColor: whiteColor,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0),
      floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: primaryLightColor),
      bottomSheetTheme: const BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ))),      textTheme: TextTheme(
    titleLarge:
        TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: whiteColor),
    titleMedium:
        TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryDarkColor),
    titleSmall:
        TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: primaryDarkColor),
  ));
  static ThemeData darkTheme = ThemeData(
      primaryColor: primaryDarkColor,
      scaffoldBackgroundColor: primaryDarkColor,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryLightColor,
        iconTheme: IconThemeData(color: primaryDarkColor),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryLightColor,
          unselectedItemColor: whiteColor,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0),
      floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: primaryLightColor),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ))),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: primaryDarkColor,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        ),
        titleSmall: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        ),
      ));
}
