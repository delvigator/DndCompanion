import 'dart:convert';

import 'package:dnd/components/snack_bar.dart';
import 'package:dnd/http/requests.dart';
import 'package:dnd/pages/auth/start.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../components/constants.dart';
import '../../components/default_button.dart';


class Register extends StatefulWidget {
  const Register({super.key});
  static String routeName = "/register";
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void initState() {
    _passwordVisible=false;
    _passwordConfirmVisible=false;
    super.initState();
  }
  late bool _passwordVisible;
  late bool _passwordConfirmVisible;
  TextEditingController mailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController passwordConfirmController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 5.h,),
                Text("Регистрация",style: Theme.of(context).textTheme.titleLarge,),
                SizedBox(height: 10.h,),
                Container(
                  width: 60.w,
                  padding: EdgeInsets.symmetric(horizontal: 10.dp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: mailController,
                    style: Theme.of(context).textTheme.bodySmall,
                    cursorColor: Colors.black45,
                    textAlignVertical: TextAlignVertical.center,
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                      FilteringTextInputFormatter.allow(passwordRegExp),
                    ],
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },

                    decoration: InputDecoration(

                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        hintText: "Введите почту",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black45)),
                  ),
                ),
                SizedBox(height: 2.h,),
                Container(
                  width: 60.w,
                  padding: EdgeInsets.symmetric(horizontal: 10.dp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    style: Theme.of(context).textTheme.bodySmall,
                    cursorColor: Colors.black45,
                    textAlignVertical: TextAlignVertical.center,
                    autofocus: false,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                      FilteringTextInputFormatter.allow(passwordRegExp),
                    ],
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        hintText: "Введите пароль",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black45)),
                  ),
                ),SizedBox(height: 2.h,),
                Container(
                  width: 60.w,
                  padding: EdgeInsets.symmetric(horizontal: 10.dp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: passwordConfirmController,
                    style: Theme.of(context).textTheme.bodySmall,
                    cursorColor: Colors.black45,
                    textAlignVertical: TextAlignVertical.center,
                    autofocus: false,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                      FilteringTextInputFormatter.allow(passwordRegExp),
                    ],
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    obscureText: !_passwordConfirmVisible,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordConfirmVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordConfirmVisible = !_passwordConfirmVisible;
                            });
                          },
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        hintText: "Подтвердите пароль",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black45)),
                  ),
                ),
                SizedBox(height:35.h),
                Container(
                    width: 50.w,
                    child: DefaultButton(text: "Зарегистрироваться",onPress: (){
                      if(mailController.text=="") {
                        showSnackBar("Введите почту");
                      } else if( passwordController.text=="")  {
                        showSnackBar("Введите пароль");
                      }
                      else {
                        onConfirm();
                      }

                    },)),

              ],
            ),
          ],
        ),
      ),
    );
  }
  onConfirm(){
tryRegister(password: passwordController.text, confirmPassword: passwordConfirmController.text, email: mailController.text, onSuccess: (headers,body){
  showSnackBar("Для завершения регистрации подтвердите адрес почты");
  Navigator.pushNamedAndRemoveUntil(context, Start.routeName,(_)=>false);
},
onError: (headers,body){
  debugPrint(body);

  showSnackBar(body);});
  }
}
