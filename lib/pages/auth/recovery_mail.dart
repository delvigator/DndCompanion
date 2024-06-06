

import 'package:dnd/components/default_button.dart';
import 'package:dnd/pages/auth/recovery_pin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../components/constants.dart';


class RecoveryMail extends StatefulWidget {
  const RecoveryMail({super.key});
  static String routeName = "/recoveryMail";
  @override
  State<RecoveryMail> createState() => _RecoveryMailState();
}

class _RecoveryMailState extends State<RecoveryMail> {
  TextEditingController mailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10.h,),
                Text("Восстановление пароля",style: Theme.of(context).textTheme.titleLarge,),
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
SizedBox(height: 10.h,),
SizedBox(
  width: 50.w,
  child: DefaultButton(text: "Далее",onPress: (){
    Navigator.pushNamed(context, RecoveryPin.routeName);
  },),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
