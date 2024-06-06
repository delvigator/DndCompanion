import 'package:dnd/bloc/character_bloc/character_bloc.dart';
import 'package:dnd/components/default_button.dart';
import 'package:dnd/http/requests.dart';
import 'package:dnd/pages/auth/recovery_mail.dart';
import 'package:dnd/pages/home/home_router.dart';
import 'package:dnd/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../components/constants.dart';
import '../../components/snack_bar.dart';
import '../../global_vars.dart';

class AuthMain extends StatefulWidget {
  const AuthMain({super.key});

  static String routeName = "/authMain";

  @override
  State<AuthMain> createState() => _AuthMainState();
}

class _AuthMainState extends State<AuthMain> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Вход",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 10.h,
                ),
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
                SizedBox(
                  height: 2.h,
                ),
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
                SizedBox(height: 35.h),
                Container(
                    width: 50.w,
                    child: DefaultButton(
                      text: "Войти",
                      onPress: () {
                        onConfirm();
                      },
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RecoveryMail.routeName);
                    },
                    child: const Text(
                      "Восстановить пароль",
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  onConfirm() {
    tryLogin(
        login: mailController.text,
        password: passwordController.text,
        onSuccess: (headers, body) {
          userData.encodeLogin(mailController.text);
          userData.encodePassword(passwordController.text);
          saveUserData();
          characterBloc.add(ChangeCharactersEvent(userData.characters));
          Navigator.pushNamedAndRemoveUntil(
              context, HomeRouter.routeName, (_) => false);
        },
        onError: (headers, body) {
          showSnackBar(body);
        });
  }
}
