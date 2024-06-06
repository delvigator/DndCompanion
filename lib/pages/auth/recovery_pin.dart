
import 'package:dnd/components/default_button.dart';
import 'package:dnd/pages/auth/recovery_change.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class RecoveryPin extends StatefulWidget {
  const RecoveryPin({super.key});
  static String routeName = "/recoveryPin";
  @override
  State<RecoveryPin> createState() => _RecoveryPinState();
}

class _RecoveryPinState extends State<RecoveryPin> {
  TextEditingController pinController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  Text("Введите код, отправленный вам на почту",textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium,),
                  SizedBox(height: 5.h,),
                  Container(
                    width: 60.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.dp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: pinController,
                      style: Theme.of(context).textTheme.bodySmall,
                      cursorColor: Colors.black45,
                      textAlignVertical: TextAlignVertical.center,
                      autofocus: false,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(40),
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
                          hintText: "Код подтверждения",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black45)),
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Container(
                    width: 50.w,
                    child: DefaultButton(text: "Далее",onPress: (){
                      Navigator.pushNamed(context, RecoveryChange.routeName);
                    },),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
