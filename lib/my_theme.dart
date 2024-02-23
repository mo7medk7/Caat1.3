import 'dart:ui';

import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLightColor = Color(0xff3498DB);
  static Color yelloColor = Color(0xffF39C12);
  static Color whiteColor = Color(0xffFFFFFF);
  static Color primaryDarkColor = Color(0xff383838);
  static Color greyColor = Color(0xff707070);
  static Color greenLight =Color(0xff61E757);
  static Color backgroundColors = Colors.grey.shade100;
  static Color redColor = Color(0xFFFE4A49);
  static Color blueTask = Color(0xff8AAFBF);
  static Color yelloTask = Color(0xffffff00);
  static Color blueColor = Color(0xff3498DB);
  static Color blackColor = Color(0xff383838);
  static Color blue2Color = Color(0xff8AAFBF);
  static Color blueDarkColor = Color(0xff192940);
  static Color blue3Color = Color(0xff22345A);


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
      primaryColor: blueDarkColor,
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
          color: blueDarkColor,
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
