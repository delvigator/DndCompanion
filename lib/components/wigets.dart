import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'our_colors.dart';

Widget simpleButton(String text,Function onPressed,Color color){
  return  Container(
    height: 5.h,
    width: 40.w,
    decoration: BoxDecoration(
        borderRadius:
        const BorderRadius.all(Radius.circular(50)),
        color: color),
    child: TextButton(
      onPressed:onPressed(),
      child: Text(text,style: const TextStyle(color: Colors.black),),
    ),
  );
}