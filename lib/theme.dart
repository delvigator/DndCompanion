

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'components/our_colors.dart';

ThemeData theme() {
  return ThemeData(
      fontFamily: 'Inter',
      dividerColor: Colors.transparent,
    appBarTheme: appBarTheme(),
      scaffoldBackgroundColor: OurColors.scaffoldBackgroundColor,
      useMaterial3: true,
      textTheme: textTheme(),
      colorScheme: ColorScheme.fromSwatch(
        backgroundColor: Colors.white,
        primarySwatch: Colors.pink,
      ).copyWith(),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: textTheme().bodySmall?.copyWith(color: OurColors.focusColorLight)
        ),
      ),
      unselectedWidgetColor: Colors.white,
      primaryColor: Colors.black,
    focusColor: OurColors.focusColorLight,
    //  appBarTheme: appBarTheme(),
      //textTheme: textTheme(),
      hintColor: Colors.black,
      //inputDecorationTheme: inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity);
}
TextTheme textTheme(){

    return TextTheme(
        bodyLarge: TextStyle(color: OurColors.textColorWhite, fontSize: 15.dp,fontFamily: "Inter"),
    // body
    bodyMedium: TextStyle(color: OurColors.textColor, fontSize: 13.dp,fontFamily: "Inter"),
        bodySmall: TextStyle(color: OurColors.textColor, fontSize: 12.dp,fontFamily: "Inter"),
    // body small
    titleMedium: TextStyle(
    color: OurColors.textColorWhite,
    fontSize: 16.dp,
      fontFamily: "Inter"
    ),
        titleSmall: TextStyle(
            color: OurColors.textColorWhite,
            fontSize: 12.dp,
            fontFamily: "Inter"
        ),
    // (default for TextField)
    headlineSmall: TextStyle(
    color: OurColors.textColor,
    fontSize: 16.dp,
    fontWeight: FontWeight.bold,
    fontFamily: "Inter"));
    // body large

  }
  AppBarTheme appBarTheme(){
return AppBarTheme(
  titleTextStyle: TextStyle(
      color: OurColors.textColorWhite,
      fontSize: 16.dp,
      fontFamily: "Inter"
  ),
  color: OurColors.backgroundColor,
  foregroundColor: OurColors.textColorWhite,
);
}