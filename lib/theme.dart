

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'components/our_colors.dart';

ThemeData theme() {
  return ThemeData(
      fontFamily: 'Inter',
    appBarTheme: appBarTheme(),
      scaffoldBackgroundColor: OurColors.scaffoldBackgroundColor,
      useMaterial3: true,
      textTheme: textTheme(),
      unselectedWidgetColor: Colors.black,
      primaryColor: Colors.black,
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
    bodyMedium: TextStyle(color: OurColors.textColor, fontSize: 14.dp,fontFamily: "Inter"),
        bodySmall: TextStyle(color: OurColors.textColor, fontSize: 12.dp,fontFamily: "Inter"),
    // body small
    titleMedium: TextStyle(
    color: OurColors.textColorWhite,
    fontSize: 16.dp,
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
return const AppBarTheme(
  color: OurColors.backgroundColor,
  foregroundColor: OurColors.textColorWhite,
);
}