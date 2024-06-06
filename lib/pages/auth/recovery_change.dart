
import 'package:dnd/pages/auth/start.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../components/constants.dart';
import '../../components/default_button.dart';


class RecoveryChange extends StatefulWidget {
  const RecoveryChange({super.key});
  static String routeName = "/change";
  @override
  State<RecoveryChange> createState() => _RecoveryChangeState();
}

class _RecoveryChangeState extends State<RecoveryChange> {
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
                SizedBox(height: 10.h,),
                Text("Введите новый пароль",style: Theme.of(context).textTheme.titleMedium,),
                SizedBox(height: 10.h,),
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

                    decoration: InputDecoration(
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

                    decoration: InputDecoration(
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
                SizedBox(height: 10.h,),
                SizedBox(
                  width: 50.w,
                  child: DefaultButton(text: "Готово",onPress: (){
                    Navigator.pushNamedAndRemoveUntil(context, Start.routeName,(_)=>false);
                  },))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
