import 'package:dnd/bloc/information_bloc/information_bloc.dart';
import 'package:dnd/components/default_button.dart';
import 'package:dnd/global_vars.dart';
import 'package:dnd/pages/spells_book/spell_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../components/our_colors.dart';
import '../../models/ch_class.dart';
import '../../models/magic_spell.dart';

class AllSpells extends StatefulWidget {
  const AllSpells({super.key});

  @override
  State<AllSpells> createState() => _AllSpellsState();
}

class _AllSpellsState extends State<AllSpells> {
  TextEditingController nameController = TextEditingController();
  List<String> levels =
      List.generate(10, (index) => index == 0 ? "Фокус" : (index).toString());

  List<bool> checksLevels = [];
  List<bool> checkClasses = [];
  List<bool> checkSchools = [];
  List<String> schools = [
    "Ограждение",
    "Вызов",
    "Прорицание",
    "Очарование",
    "Воплощение",
    "Иллюзия",
    "Некромантия",
    "Трансмутация"
  ];
  List<MagicSpell> allSpells = [];
  List<ChClass> classes = [];
  bool isChanged = false;

  @override
  Widget build(BuildContext context) {
    TextStyle? small = Theme.of(context).textTheme.bodySmall;
    TextStyle? verySmall =
        Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.dp);
    if (checkSchools.isEmpty) {
      checkSchools = List.generate(schools.length, (index) => true);
    }
    if (checksLevels.isEmpty) {
      checksLevels =
          List.generate(levels.length, (index) => index == 0 ? true : false);
    }
    return BlocBuilder<InformationBloc, InformationState>(
      bloc: informationBloc,
      builder: (context, state) {
        informationBloc.add(LoadClassesEvent(context));
        informationBloc.add(LoadSpellsEvent(context));
        if (classes.isEmpty) classes = informationBloc.state.classes;
        if (checkClasses.isEmpty) {
          checkClasses = List.generate(classes.length, (index) => true);
        }
        if (allSpells.isEmpty && isChanged == false) {
          allSpells=informationBloc.state.spells;
          // allSpells = List.generate(informationBloc.state.spells.length,
          //     (index) => informationBloc.state.spells[index]);
        }

        // debugPrint(informationBloc.state.classes.length.toString());
        //  classes=informationBloc.state.classes;
        return Expanded(
            child: ListView(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.dp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: nameController,
                      style: Theme.of(context).textTheme.bodySmall,
                      cursorColor: Colors.black45,
                      textAlignVertical: TextAlignVertical.center,
                      autofocus: false,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
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
                          hintText: "Название",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black45)),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Card(
                      color: OurColors.focusColorTileLight,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        // side: BorderSide(
                        //   color: Colors.white,
                        //   width: 1.0,
                        // ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ExpansionTile(
                          collapsedBackgroundColor:
                              OurColors.focusColorTileLight,
                          backgroundColor: OurColors.focusColorTileLight,
                          iconColor: Colors.white,
                          //  subtitle: Text(element.value.name,style: small,),
                          collapsedIconColor: Colors.white,
                          title: Text("Школа",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white)),
                          children: [
                            Container(
                                padding: EdgeInsets.all(12.dp),
                                color: Colors.white,
                                child: Column(
                                    children: schools
                                        .asMap()
                                        .entries
                                        .map((element) => Padding(
                                              padding: EdgeInsets.all(5.dp),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  // SizedBox(width: 2.w),
                                                  Text(element.value),
                                                  SizedBox(width: 10.w),
                                                  Container(
                                                    width: 24.dp,
                                                    height: 24.dp,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 1),
                                                    ),
                                                    child: Theme(
                                                      data: ThemeData(
                                                          unselectedWidgetColor:
                                                              Colors.white),
                                                      child: Checkbox(
                                                        checkColor:
                                                            Colors.black,
                                                        activeColor:
                                                            Colors.transparent,
                                                        tristate: false,
                                                        value: checkSchools[
                                                            element.key],
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            checkSchools[element
                                                                .key] = value!;

                                                            //characterBloc.add(DeleteAllSelectedSpellsEvent());
                                                            // checksLevels
                                                            //     .asMap()
                                                            //     .entries
                                                            //     .forEach(
                                                            //         (i) {
                                                            //       if (i.value ==
                                                            //           true) {
                                                            //         character
                                                            //             .selectedSpells
                                                            //             .asMap()
                                                            //             .entries
                                                            //             .forEach(
                                                            //                 (j) {
                                                            //               if (j.value.level ==
                                                            //                   i.key) {
                                                            //                 characterBloc.add(AddSelectedSpellEvent(j.value));
                                                            //               }
                                                            //             });
                                                            //       }
                                                            //     });
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 15.w),
                                                ],
                                              ),
                                            ))
                                        .toList()))
                          ])),
                  Card(
                      color: OurColors.focusColorTileLight,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        // side: BorderSide(
                        //   color: Colors.white,
                        //   width: 1.0,
                        // ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ExpansionTile(
                          collapsedBackgroundColor:
                              OurColors.focusColorTileLight,
                          backgroundColor: OurColors.focusColorTileLight,
                          iconColor: Colors.white,
                          //  subtitle: Text(element.value.name,style: small,),
                          collapsedIconColor: Colors.white,
                          title: Text("Класс",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white)),
                          children: [
                            Container(
                                padding: EdgeInsets.all(12.dp),
                                color: Colors.white,
                                child: Column(
                                    children: classes
                                        .asMap()
                                        .entries
                                        .map((element) => Padding(
                                              padding: EdgeInsets.all(5.dp),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  // SizedBox(width: 2.w),
                                                  Text(element.value.name),
                                                  SizedBox(width: 10.w),
                                                  Container(
                                                    width: 24.dp,
                                                    height: 24.dp,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 1),
                                                    ),
                                                    child: Theme(
                                                      data: ThemeData(
                                                          unselectedWidgetColor:
                                                              Colors.white),
                                                      child: Checkbox(
                                                        checkColor:
                                                            Colors.black,
                                                        activeColor:
                                                            Colors.transparent,
                                                        tristate: false,
                                                        value: checkClasses[
                                                            element.key],
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            checkClasses[element
                                                                .key] = value!;

                                                            //characterBloc.add(DeleteAllSelectedSpellsEvent());
                                                            // checksLevels
                                                            //     .asMap()
                                                            //     .entries
                                                            //     .forEach(
                                                            //         (i) {
                                                            //       if (i.value ==
                                                            //           true) {
                                                            //         character
                                                            //             .selectedSpells
                                                            //             .asMap()
                                                            //             .entries
                                                            //             .forEach(
                                                            //                 (j) {
                                                            //               if (j.value.level ==
                                                            //                   i.key) {
                                                            //                 characterBloc.add(AddSelectedSpellEvent(j.value));
                                                            //               }
                                                            //             });
                                                            //       }
                                                            //     });
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 15.w),
                                                ],
                                              ),
                                            ))
                                        .toList()))
                          ])),
                  Card(
                      color: OurColors.focusColorTileLight,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        // side: BorderSide(
                        //   color: Colors.white,
                        //   width: 1.0,
                        // ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ExpansionTile(
                          collapsedBackgroundColor:
                              OurColors.focusColorTileLight,
                          backgroundColor: OurColors.focusColorTileLight,
                          iconColor: Colors.white,
                          //  subtitle: Text(element.value.name,style: small,),
                          collapsedIconColor: Colors.white,
                          title: Text("Уровень заклинаний",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white)),
                          children: [
                            Container(
                                padding: EdgeInsets.all(12.dp),
                                color: Colors.white,
                                child: Column(
                                    children: levels
                                        .asMap()
                                        .entries
                                        .map((element) => Padding(
                                              padding: EdgeInsets.all(5.dp),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  // SizedBox(width: 2.w),
                                                  element.key == 0
                                                      ? Text(element.value)
                                                      : Text(
                                                          "${element.value} уровень"),
                                                  SizedBox(width: 10.w),
                                                  Container(
                                                    width: 24.dp,
                                                    height: 24.dp,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 1),
                                                    ),
                                                    child: Theme(
                                                      data: ThemeData(
                                                          unselectedWidgetColor:
                                                              Colors.white),
                                                      child: Checkbox(
                                                        checkColor:
                                                            Colors.black,
                                                        activeColor:
                                                            Colors.transparent,
                                                        tristate: false,
                                                        value: checksLevels[
                                                            element.key],
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            checksLevels[element
                                                                .key] = value!;

                                                            //characterBloc.add(DeleteAllSelectedSpellsEvent());
                                                            // checksLevels
                                                            //     .asMap()
                                                            //     .entries
                                                            //     .forEach(
                                                            //         (i) {
                                                            //       if (i.value ==
                                                            //           true) {
                                                            //         character
                                                            //             .selectedSpells
                                                            //             .asMap()
                                                            //             .entries
                                                            //             .forEach(
                                                            //                 (j) {
                                                            //               if (j.value.level ==
                                                            //                   i.key) {
                                                            //                 characterBloc.add(AddSelectedSpellEvent(j.value));
                                                            //               }
                                                            //             });
                                                            //       }
                                                            //     });
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 15.w),
                                                ],
                                              ),
                                            ))
                                        .toList()))
                          ])),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    width: 50.w,
                    height: 5.h,
                    child: DefaultButton(
                      text: "Применить",
                      onPress: () {
                        setState(() {
                          isChanged = true;
                          allSpells = [];
                          informationBloc.state.spells.asMap().entries.forEach((element) {
                            int level =element.value.level;
                            String name=element.value.name;
                            List<String> elClasses=element.value.classes;
                            bool checkLevel=false;
                            bool checkName=false;
                            bool checkSchoolClass=false;
                            if(checksLevels[level]==true) {
                              checkLevel=true;
                            }
                            else {
                              checkLevel=false;
                            }
                            debugPrint(checkLevel.toString());
                            if(nameController.text=="" || nameController.text==name){
                              checkName=true;
                            }
                            else{checkName=false;}
                            debugPrint(checkName.toString());
                            int numberClasses=0;
                            classes.asMap().entries.forEach((chClass) {
                              if(elClasses.contains(chClass.value.name) && checkClasses[chClass.key]==true) numberClasses++;
                            });
                            debugPrint("number classes $numberClasses");
                            int schoolIndex=schools.indexOf(element.value.school);
                            debugPrint("schoolIndex $schoolIndex");
                            if(schoolIndex!=-1 && checkSchools[schoolIndex]==true && numberClasses>0) {
                              checkSchoolClass=true;
                            } else {checkSchoolClass=false;}


                            if(checkSchoolClass==true && checkName==true && checkLevel==true && !allSpells.contains(element.value)) {
                              debugPrint("add ${element.value.name}");
                              allSpells.add(element.value);
                            } else {
                              debugPrint("remove ${element.value.name}");
                              allSpells.remove(element.value);
                            }
                          });
                          // checksLevels.asMap().entries.forEach((check) {
                          //   informationBloc.state.spells
                          //       .asMap()
                          //       .entries
                          //       .forEach((element) {
                          //     if (check.value) {
                          //       if (element.value.level == check.key &&
                          //           !allSpells.contains(element.value)) {
                          //         debugPrint("Добавляем уровень ${element.value.level}");
                          //         allSpells.add(element.value);
                          //       }
                          //     } else if (element.value.level == check.key){
                          //       debugPrint("Убираем уровень ${element.value.level}");
                          //       allSpells.remove(element.value);
                          //     }
                          //   });
                          // });
                          //
                          // checkSchools.asMap().entries.forEach((check) {
                          //   informationBloc.state.spells
                          //       .asMap()
                          //       .entries
                          //       .forEach((element) {
                          //     if (check.value) {
                          //       if (element.value.school ==
                          //               schools[element.key] &&
                          //           !allSpells.contains(element.value)) {
                          //         allSpells.add(element.value);
                          //       } else {
                          //         allSpells.remove(element.value);
                          //       }
                          //     } else {
                          //       allSpells.remove(element.value);
                          //     }
                          //   });
                          // });
                          //
                          // checkClasses.asMap().entries.forEach((check) {
                          //   informationBloc.state.spells
                          //       .asMap()
                          //       .entries
                          //       .forEach((element) {
                          //     if (check.value) {
                          //       if (element.value.classes
                          //               .contains(classes[check.key].name) &&
                          //           !allSpells.contains(element.value)) {
                          //         allSpells.add(element.value);
                          //       }
                          //     }
                          //   });
                          // });

                          isChanged == false;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Column(
                    children: allSpells
                        .asMap()
                        .entries
                        .map((e) => Padding(
                              padding: EdgeInsets.only(
                                  left: 2.w, right: 2.w, bottom: 1.h),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      SpellDescription.routeName,
                                      arguments: {"spell": e.value});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15.dp),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(e.value.name),
                                          Text(
                                            e.value.school,
                                            style: verySmall,
                                          ),
                                          Text(
                                            e.value.timeApplication,
                                            style: verySmall,
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          e.value.level == 0
                                              ? Text(
                                                  "Фокус",
                                                  style: small,
                                                )
                                              : Text(
                                                  "${e.value.level} уровень",
                                                  style: small,
                                                ),
                                          Row(
                                            children:
                                                e.value.spellComponents.entries
                                                    .map((comp) => Text(
                                                          "${comp.key}. ",
                                                          style: small,
                                                        ))
                                                    .toList(),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ));
      },
    );
  }
}
