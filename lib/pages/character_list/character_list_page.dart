import 'dart:io';

import 'package:dnd/bloc/character_bloc/character_bloc.dart';
import 'package:dnd/models/character_info.dart';
import 'package:dnd/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/our_colors.dart';
import '../../global_vars.dart';
import '../../models/character.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  int currentCh = characterBloc.state.currentCharacter;

  @override
  void initState() {
    readPrefs(context);
    super.initState();
  }

  String? _image;
  bool inProcess = false;
  TextEditingController pointsController = TextEditingController();
  TextEditingController armorController = TextEditingController();
  TextEditingController initController = TextEditingController();
  TextEditingController speedController = TextEditingController();
  TextEditingController masteryController = TextEditingController();
  TextEditingController hpController = TextEditingController();
  TextEditingController tempHpController = TextEditingController();
  selectImageFromGallery() async {
    final picker = ImagePicker();
    setState(() {
      inProcess = true;
    });
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      _image = imageFile.path;
      Character? character = characterBloc.state.characters[currentCh].copyWith(
          portrait: _image);
      characterBloc.add(ChangeCharacterEvent(character));
    }
    setState(() {
      inProcess = false;
    });
  }

  bool edited = false;

  @override
  Widget build(BuildContext context) {
    TextStyle? big =
    Theme
        .of(context)
        .textTheme
        .titleLarge
        ?.copyWith(color: Colors.black, decoration: TextDecoration.underline);
    TextStyle? middle =
    Theme
        .of(context)
        .textTheme.titleMedium
        ?.copyWith(color: Colors.black);
    TextStyle? small =
    Theme
        .of(context)
        .textTheme
        .bodySmall
        ?.copyWith(fontSize: 12.dp);
    TextStyle? verySmall =
    Theme
        .of(context)
        .textTheme
        .bodySmall
        ?.copyWith(fontSize: 8.dp);
    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: characterBloc,
      builder: (context, state) {
        if (characterBloc.state.currentCharacter != -1 && !edited) {
          edited = true;
          pointsController.text =
              characterBloc.state.characters[currentCh].characterInfo
                  .experiencePoints
                  .toString();
          armorController.text =
              characterBloc.state.characters[currentCh].characterInfo.armorClass
                  .toString();
          initController.text =
              characterBloc.state.characters[currentCh].characterInfo.initiative
                  .toString();
          speedController.text =
              characterBloc.state.characters[currentCh].characterInfo.speed
                  .toString();
          masteryController.text =
              characterBloc.state.characters[currentCh].characterInfo.mastery
                  .toString();

          hpController.text =
              characterBloc.state.characters[currentCh].characterInfo.currentHealth
                  .toString();

          tempHpController.text =
              characterBloc.state.characters[currentCh].characterInfo.tempHealth
                  .toString();
          _image = characterBloc.state.characters[currentCh].portrait;
        }
        return Scaffold(
          appBar: AppBar(
            title: characterBloc.state.currentCharacter != -1 ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  characterBloc.state.characters[currentCh].name, style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,),
                Text(characterBloc.state.characters[currentCh].chRace.name,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white60),)
              ],
            ) : Container(),
          ),
          body: characterBloc.state.currentCharacter == -1
              ? Center(
              heightFactor: 2.8.h,
              child: Text(
                "Сначала выберите персонажа",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.white),
              ))
              : Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.w, vertical: 1.h),
                      alignment: Alignment.topLeft,
                      height: 11.h,
                      width: 27.w,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(20),
                          color: OurColors.focusColor),
                      child: SingleChildScrollView(
                        child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: characterBloc.state
                                  .characters[currentCh].chClass.map((element) =>
                                  Text(
                                    "${element.name} ${element
                                        .level} уровень",
                                    textAlign: TextAlign.center,
                                    style: verySmall,
                                  )).toList(),
                              //       children: [
                              //         Text(
                              //   "${characterBloc.state.currentCharacter!.level} уровень",
                              //   textAlign: TextAlign.center,
                              //   style: verySmall,
                              // ),

                            )),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: selectImageFromGallery,
                      child: Container(
                        width: 28.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            image: _image != null
                                ? DecorationImage(
                                image: FileImage(File(_image!)),
                                fit: BoxFit.fill)
                                : null),
                        child: _image == null
                            ? Padding(
                            padding: EdgeInsets.all(7.dp),
                            child: Center(
                                child: Text(
                                  "Нет изображения",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                    color: Colors.black26,
                                    fontSize: 10.dp,
                                  ),
                                  textAlign: TextAlign.center,
                                )))
                            : null,
                      )),

                  SizedBox(
                    width: 2.w,
                  ),
                  Container(
                      width: 27.w,
                      height: 11.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: getBox(
                          big!, "Очки опыта", pointsController, () {
                        CharacterInfo characterInfo = characterBloc.state
                            .characters[currentCh].characterInfo.copyWith(
                            experiencePoints: int.parse(
                                pointsController.text));
                        Character character = characterBloc.state
                            .characters[currentCh].copyWith(
                            characterInfo: characterInfo);
                        characterBloc.add(ChangeCharacterEvent(character));
                        // debugPrint( characterBloc.state.characters[currentCh].characterInfo.experiencePoints.toString());
                      }))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 26.w,
                        height: 11.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: getBox(
                            big, "Класс брони", armorController, () {
                          CharacterInfo characterInfo = characterBloc.state
                              .characters[currentCh].characterInfo.copyWith(
                              armorClass: int.parse(armorController.text));
                          Character character = characterBloc.state
                              .characters[currentCh].copyWith(
                              characterInfo: characterInfo);
                          characterBloc.add(
                              ChangeCharacterEvent(character));
                        })),
                    SizedBox(width: 2.w,),
                    Container(
                        width: 26.w,
                        height: 11.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: getBox(
                            big, "Инициатива", initController, () {
                          CharacterInfo characterInfo = characterBloc.state
                              .characters[currentCh].characterInfo.copyWith(
                              initiative: int.parse(initController.text));
                          Character character = characterBloc.state
                              .characters[currentCh].copyWith(
                              characterInfo: characterInfo);
                          characterBloc.add(
                              ChangeCharacterEvent(character));
                        }
                        )),
                    SizedBox(width: 2.w,),
                    Container(
                        width: 26.w,
                        height: 11.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: getBox(big, "Скорость", speedController, () {
                          CharacterInfo characterInfo = characterBloc.state
                              .characters[currentCh].characterInfo.copyWith(
                              speed: int.parse(speedController.text));
                          Character character = characterBloc.state
                              .characters[currentCh].copyWith(
                              characterInfo: characterInfo);
                          characterBloc.add(
                              ChangeCharacterEvent(character));
                        }))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Container(
                    width: 26.w,
                    height: 13.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: getBox(big, "Бонус мастерства", masteryController, () {
                      CharacterInfo characterInfo = characterBloc.state
                          .characters[currentCh].characterInfo.copyWith(
                          mastery: int.parse(masteryController.text));
                      Character character = characterBloc.state
                          .characters[currentCh].copyWith(
                          characterInfo: characterInfo);
                      characterBloc.add(
                          ChangeCharacterEvent(character));
                    })),
                      SizedBox(width: 2.w,),

                Container(
                  width: 25.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Container(
                    padding: EdgeInsets.all(5.dp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "ОЗ, текущие",
                          textAlign: TextAlign.center,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 10.dp),
                        ),
                        TextFormField(
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus
                                ?.unfocus();
                            if (hpController.text != "") {
                              saveCharacterInfo();
                              CharacterInfo characterInfo = characterBloc.state
                                  .characters[currentCh].characterInfo.copyWith(
                                  currentHealth: int.parse(hpController.text));
                              Character character = characterBloc.state
                                  .characters[currentCh].copyWith(
                                  characterInfo: characterInfo);
                              characterBloc.add(
                                  ChangeCharacterEvent(character));
                            }
                          },
                          textAlign: TextAlign.center,
                          cursorColor: Colors.black45,
                          textAlignVertical:
                          TextAlignVertical.center,
                          autofocus: false,
                          decoration: const InputDecoration(
                            enabledBorder:
                            UnderlineInputBorder(
                              borderSide: BorderSide(
                                  style: BorderStyle.none),
                            ),
                            focusedBorder:
                            UnderlineInputBorder(
                              borderSide: BorderSide(
                                  style: BorderStyle.none),
                            ),),
                          style: big,
                          inputFormatters: [
                            FilteringTextInputFormatter
                                .digitsOnly,
                            LengthLimitingTextInputFormatter(
                                3),
                          ],
                          //  onChanged: controller.text!="" ? onEdit(): (e){},
                          controller: hpController,
                        ),
                        Text(
                          "Всего: ${characterBloc.state.characters[currentCh].characterInfo.allHealth}",
                          textAlign: TextAlign.center,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 10.dp),
                        ),
                      ],
                    ),
                  ),
                ),
                      SizedBox(width: 2.w,),
                      Container(
                          width: 25.w,
                          height: 13.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: getBox(big, "ОЗ, временные", tempHpController, () {
                            CharacterInfo characterInfo = characterBloc.state
                                .characters[currentCh].characterInfo.copyWith(
                                speed: int.parse(tempHpController.text));
                            Character character = characterBloc.state
                                .characters[currentCh].copyWith(
                                characterInfo: characterInfo);
                            characterBloc.add(
                                ChangeCharacterEvent(character));
                          }))
                ],
              ),

          ),
                   Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                     getCh("Сила"),
                        SizedBox(width: 2.w),
                        getCh("Ловкость"),
                        SizedBox(width: 2.w),
                        getCh("Телосложение")
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getCh("Интеллект"),
                        SizedBox(width: 2.w),
                        getCh("Мудрость"),
                        SizedBox(width: 2.w),
                        getCh("Харизма")
                      ],
                    ),
                  )
          ],
        ),
            ),)
        );
      }
    );
  }

  Widget getBox(TextStyle style, String text, TextEditingController controller,
      Function onEdit) {
    return Container(
      width: 25.w,
      height: 11.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white),
      child: Container(
        padding: EdgeInsets.all(5.dp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 8.dp),
            ),
            TextFormField(
              onFieldSubmitted: (event){
                if (controller.text != "") {
                  saveCharacterInfo();
                  onEdit();
                }
              },
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus
                    ?.unfocus();
                if (controller.text != "") {
                  saveCharacterInfo();
                  onEdit();
                }
              },
              textAlign: TextAlign.center,
              cursorColor: Colors.black45,
              textAlignVertical:
              TextAlignVertical.center,
              autofocus: false,
              decoration: const InputDecoration(
                enabledBorder:
                UnderlineInputBorder(
                  borderSide: BorderSide(
                      style: BorderStyle.none),
                ),
                focusedBorder:
                UnderlineInputBorder(
                  borderSide: BorderSide(
                      style: BorderStyle.none),
                ),),
              style: style,
              inputFormatters: [
                FilteringTextInputFormatter
                    .digitsOnly,
                LengthLimitingTextInputFormatter(
                    3),
              ],
              //  onChanged: controller.text!="" ? onEdit(): (e){},
              controller: controller,
            )
          ],
        ),
      ),
    );
  }
Widget getCh(String text){
    return   Stack(
        children:[
          Container(
            width: 25.w,
            height: 13.h,
            color: OurColors.backgroundColor,
          ),
          Container(
            width: 25.w,
            height: 11.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white),
            child: Container(
              padding: EdgeInsets.all(5.dp),
              child: Column(
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 8.dp),
                  ),
                  SizedBox(height: 1.h,),
                  Text(
                  ((characterBloc.state.characters[currentCh].characteristics.getCharacteristicByName(text)-10)/2).floor().toString() ,
                    textAlign: TextAlign.center,
                    style:  Theme
                        .of(context)
                        .textTheme.titleMedium
                        ?.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 20,
              right: 20,
              child:
              SizedBox(
                child: Container(
                  width: 0.5.w,
                  height: 5.h,
                  decoration:  BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(100),bottom: Radius.circular(100)),
                      color: Colors.white
                  ),
                  child: Center(
                    child: Text(
                      characterBloc.state.characters[currentCh].characteristics.getCharacteristicByName(text).toString(),
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme.bodyMedium


                          ?.copyWith(fontSize: 13.dp),
                    ),
                  ),
                ),
              ))
        ]
    );
}
}
