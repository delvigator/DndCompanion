import 'package:dnd/bloc/character_bloc/character_bloc.dart';
import 'package:dnd/components/snack_bar.dart';
import 'package:dnd/models/ch_race.dart';
import 'package:dnd/pages/character_selector/character_creation/creation_final.dart';
import 'package:dnd/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../bloc/information_bloc/information_bloc.dart';
import '../../../components/default_button.dart';
import '../../../components/our_colors.dart';
import '../../../global_vars.dart';
import '../../../models/ch_class.dart';
import '../../../models/character.dart';

class CreationClass extends StatefulWidget {
  const CreationClass({super.key});

  static String routeName = "/creationClass";

  @override
  State<CreationClass> createState() => _CreationClassState();
}

class _CreationClassState extends State<CreationClass> {
  ChClass? currentClass;

  int currentNumber = 1;
  TextEditingController healthController = TextEditingController();
@override
  void initState() {
  informationBloc.add(LoadClassesEvent(context));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    ChRace? currentRace = args["currentRace"];
    ChRace? currentSubRace = args["currentSubRace"];
    int mod = args["mod"];
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 40) / 2;
    final double itemWidth = size.width / 2.5;
    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: characterBloc,
      builder: (context, state) {
        if (mod == 1 &&  healthController.text=="") {
          healthController.text = characterBloc
              .state
              .characters[characterBloc.state.currentCharacter]
              .characterInfo
              .allHealth
              .toString();
        }
        return Scaffold(
            appBar: AppBar(
                title: mod == 0
                    ? Text("Создание персонажа")
                    : Text("Увеличение уровня"),
                leading: const BackButton(
                  color: Colors.white,
                )),
            body: BlocBuilder<InformationBloc, InformationState>(
              bloc: informationBloc,
              builder: (context, state) {
                return SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.all(20.dp),
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(bottom: 10.w),
                          alignment: Alignment.topLeft,
                          child: mod == 0
                              ? Text("Выберите класс",
                                  style:
                                      Theme.of(context).textTheme.titleMedium)
                              : Text(
                                  "Выберите класс, уровень в котором вы хотите поднять."
                                  " В случае, если вы выберите класс, уровень в котором у вас уже имеется, он увеличится на один."
                                  " В ином случае это будет считаться как мультиклассирование",
                                  style:
                                      Theme.of(context).textTheme.titleSmall)),
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              OurColors.lightPink,
                              Colors.white.withOpacity(0.05)
                            ],
                            stops: const [0.9, 1],
                            tileMode: TileMode.mirror,
                          ).createShader(bounds);
                        },
                        child: SizedBox(
                          width: 400.dp,
                          height: informationBloc.state.classes.length > 4
                              ? 120.dp
                              : 60.dp,
                          child: GridView.count(
                              shrinkWrap: true,
                              childAspectRatio: (itemWidth / itemHeight),
                              crossAxisCount:
                                  informationBloc.state.classes.length > 4
                                      ? 2
                                      : 1,
                              physics: const ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              children: informationBloc.state.classes
                                  .map((e) => DefaultButton(
                                        primaryColor: currentClass == e
                                            ? OurColors.lightPink
                                            : OurColors.focusColor,
                                        text: e.name,
                                        onPress: () {
                                          debugPrint(currentClass?.name);
                                          debugPrint(e.name);
                                          setState(() {
                                            currentClass = e;
                                          });
                                        },
                                      ))
                                  .toList()),
                        ),
                      ),
                      mod == 1
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Новое количество очков здоровья: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  Container(
                                      height: 4.h,
                                      width: 15.w,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.dp, vertical: 2.dp),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          controller: healthController,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(3),
                                          ],
                                          cursorColor: Colors.black45,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    style: BorderStyle.none),
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    style: BorderStyle.none),
                                              ),
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Colors.black45)),
                                        ),
                                      ))
                                ],
                              ),
                            )
                          : Container(),
                      currentClass != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding:
                                        EdgeInsets.only(top: 10.w, bottom: 5.w),
                                    alignment: Alignment.topLeft,
                                    child: Text("Информация",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium)),
                                Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                        "${currentClass?.classInfo.description}",
                                        textAlign: TextAlign.justify,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.white))),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 4.w),
                                    alignment: Alignment.topLeft,
                                    child: Text("Умения",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: currentClass!.classSkillsText
                                      .map((perc) => RichText(
                                          textScaleFactor: 1,
                                          selectionColor: Colors.white,
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                              text: "${perc.title} ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              children: [
                                                TextSpan(
                                                    text: "${perc.text} \n",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            color:
                                                                Colors.white)),
                                              ])))
                                      .toList(),
                                ),
                                currentClass?.classSkillsPerLevel != null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Умения за уровень",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.dp),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 5.h,
                                                        width: 10.w,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              if (currentNumber >
                                                                  1) {
                                                                currentNumber--;
                                                              }
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: Colors.black,
                                                            size: 10.dp,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        currentNumber
                                                            .toString(),
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 5.h,
                                                        width: 10.w,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            if (currentNumber <
                                                                20) {
                                                              currentNumber++;
                                                            }
                                                          },
                                                          child: Icon(Icons.add,
                                                              color:
                                                                  Colors.black,
                                                              size: 10.dp),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.dp),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                    textAlign: TextAlign.start,
                                                    text: TextSpan(
                                                        text:
                                                            "Бонус мастерства: ",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                        children: [
                                                          TextSpan(
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .white),
                                                              text:
                                                                  "+${currentClass?.getSkillsByLevel(currentNumber)?.masteryBonus}")
                                                        ])),
                                                RichText(
                                                    textAlign: TextAlign.start,
                                                    text: TextSpan(
                                                        text: "Умения: ",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                        children: currentClass
                                                            ?.getSkillsByLevel(
                                                                currentNumber)
                                                            ?.classSkills
                                                            .asMap()
                                                            .entries
                                                            .map((e) => TextSpan(
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyMedium
                                                                    ?.copyWith(
                                                                        color: Colors
                                                                            .white),
                                                                text: e.key + 1 == (currentClass?.getSkillsByLevel(currentNumber)!.classSkills.length)
                                                                    ? "${e.value.skillName}."
                                                                    : "${e.value.skillName}, "))
                                                            .toList())),
                                                RichText(
                                                    textAlign: TextAlign.start,
                                                    text: TextSpan(
                                                        text:
                                                            "Известные заклинания: ",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                        children: [
                                                          TextSpan(
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .white),
                                                              text:
                                                                  "${currentClass?.getSkillsByLevel(currentNumber)?.numberKnownSpells}")
                                                        ])),
                                                RichText(
                                                    textAlign: TextAlign.start,
                                                    text: TextSpan(
                                                        text:
                                                            "Известные заговоры: ",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                        children: [
                                                          TextSpan(
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .white),
                                                              text:
                                                                  "${currentClass?.getSkillsByLevel(currentNumber)?.numberKnownFocuses}")
                                                        ])),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    : Container(),
                                currentClass?.classSkillsPerLevel != null &&
                                        currentClass?.getSkillsByLevel(
                                                currentNumber) !=
                                            null
                                    ? Column(
                                        children: [
                                          Text(
                                            "Ячейки заклинаний на уровень заклинаний",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(color: Colors.white),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.dp),
                                            child: Container(
                                                padding: EdgeInsets.all(5.dp),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: currentClass!
                                                          .getSkillsByLevel(
                                                              currentNumber)!
                                                          .spellSlots
                                                          .keys
                                                          .map((e) => Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10
                                                                          .dp),
                                                              child: Text(e)))
                                                          .toList(),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: currentClass!
                                                          .getSkillsByLevel(
                                                              currentNumber)!
                                                          .spellSlots
                                                          .values
                                                          .map((e) => Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10
                                                                          .dp),
                                                              child: Text(e
                                                                  .toString())))
                                                          .toList(),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      )
                                    : Container()
                              ],
                            )
                          : Container(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: currentClass == null && mod==0 ? 55.h : currentClass == null && mod==1 ? 40.h : 0),
                          Container(
                              alignment: Alignment.bottomRight,
                              child: DefaultButton(
                                primaryColor: OurColors.focusColorLight,
                                text: mod == 0 ? "Далее" : "Сохранить",
                                onPress: () {
                                  if (currentClass != null) {
                                    if (mod == 0) {
                                      Navigator.of(context).pushNamed(
                                          CreationFinal.routeName,
                                          arguments: {
                                            "currentClass": currentClass,
                                            "currentRace": currentRace,
                                            "currentSubRace": currentSubRace
                                          });
                                    }
                                    else{
                                      Character character=characterBloc.state.characters[characterBloc.state.currentCharacter];
                                      if(character.chClass.contains(currentClass)){
                                        character.chClass[character.chClass.indexOf(currentClass!)].level++;
                                      }
                                      else{
                                        character.chClass.add(currentClass!);
                                      }
                                      character.characterInfo.allHealth=int.parse(healthController.text);
                                      character.level++;
                                      character.characterInfo.experiencePoints=0;
                                      characterBloc.add(ChangeCharacterEvent(character));
                                      saveCharacterInfo();
                                      Navigator.of(context).pop();
                                    }
                                  } else {
                                    showSnackBar("Выберите класс");
                                  }
                                },
                              )),
                        ],
                      )
                    ],
                  ),
                ));
              },
            ));
      },
    );
  }
}
