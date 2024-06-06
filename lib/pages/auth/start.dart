
import 'package:dnd/components/default_button.dart';
import 'package:dnd/pages/auth/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'auth_main.dart';


class Start extends StatefulWidget {
  const Start({super.key});
  static String routeName = "/start";
  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/logo.svg",width: 42.w, height: 35.h,),
          SizedBox(height: 6.h,),
          Container(
            width: 50.w,
              child:  DefaultButton( text: 'Войти',onPress: (){
                Navigator.pushNamed(context, AuthMain.routeName);
              },)),
      SizedBox(height: 1.h,),
      SizedBox(
        width: 50.w,
          child:
           DefaultButton( text: 'Регистрация',onPress: (){
            Navigator.pushNamed(context, Register.routeName);
          },)),
        ],
      ),
    );
  }
}
