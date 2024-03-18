import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';



Widget simpleButton(Text text,Function onPressed,Color color,double height,double width){
  return  Container(
    height: 5.h,
    width: 10.w,
    decoration: BoxDecoration(
        borderRadius:
        const BorderRadius.all(Radius.circular(20)),
        color: color),
    child: TextButton(
      onPressed: onPressed(),
      child: text,
    ),
  );
}