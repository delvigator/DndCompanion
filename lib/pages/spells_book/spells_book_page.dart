import 'package:dnd/bloc/character_bloc/character_bloc.dart';
import 'package:dnd/global_vars.dart';
import 'package:dnd/pages/spells_book/spell_description.dart';
import 'package:dnd/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../bloc/information_bloc/information_bloc.dart';
import '../../components/our_colors.dart';
import '../../models/character.dart';

class SpellsBookPage extends StatefulWidget {
  const SpellsBookPage({super.key});

  @override
  State<SpellsBookPage> createState() => _SpellsBookPageState();
}

class _SpellsBookPageState extends State<SpellsBookPage> {
  Map<String, List<TextEditingController>> spells = globalSpells;
  List<String> levels = List.generate(
      10, (index) => index == 0 ? "Фокус" : (index).toString());
  List<bool> checks = [];

  @override
  void initState() {
    super.initState();
  readPrefs(context);
    // TODO: implement initState
    setState(() {
      checks=globalChecks;
    });
  }
  @override
  Widget build(BuildContext context) {
    checks=globalChecks;
    if (globalChecks.isEmpty) {
      checks =
          List.generate(levels.length, (index) => index == 0 ? true : false);
      globalChecks = checks;
    } else {
      checks = globalChecks;
    }

    TextStyle? small = Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.dp);
    TextStyle? verySmall =
        Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.dp);

    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: characterBloc,
      builder: (context, state) {
        int index=characterBloc.state.currentCharacter;
        if (characterBloc.state.currentCharacter != -1 && globalSpells.isEmpty) {
          for (var element in characterBloc.state.characters[index].chClass) {
            spells.putIfAbsent(element.name,
                () => List.generate(9, (index) => TextEditingController()));
            spells[element.name]?.asMap().forEach((key, value) {
              if(element
                  .getSkillsByLevel(characterBloc.state.characters[index].level)?.spellSlots!=null) {
                value.text = element
                  .getSkillsByLevel(characterBloc.state.characters[index].level)!
                  .spellSlots![(key + 1).toString()]
                  .toString();
              }
              else {
                value.text="0";
              }
            });
          }
          globalSpells = spells;
        }
        if (index != -1) {
          checks.asMap().entries.forEach((i) {
            if (i.value == true) {
              characterBloc.state.characters[index].knownSpells.asMap().entries.forEach((j) {
                if (j.value.level == i.key) {
                 characterBloc.add(AddSelectedSpellEvent(j.value));
                }
              });
            }
          });
        }
        return index == -1
            ? Center(
                heightFactor: 2.8.h,
                child: Text(
                  "Сначала выберите персонажа",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                ))
            : Expanded(
                child: ListView(children: [
                  SafeArea(
                    child: Column(
                      children: [
                        Column(
                            children: characterBloc.state.characters[index].chClass
                                .asMap()
                                .entries
                                .map((element) => Card(
                                      color: OurColors.focusColor,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: ExpansionTile(
                                        backgroundColor: OurColors.focusColor,
                                        iconColor: Colors.black,
                                        subtitle: Text(
                                          element.value.name,
                                          style: small,
                                        ),
                                        collapsedIconColor: Colors.black,
                                        title: Text("Ячейки заклинаний",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(12.dp),
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2.h),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        "Уровень",
                                                        style: small,
                                                      ),
                                                      Text(
                                                        "Всего",
                                                        style: small,
                                                      ),
                                                      Text(
                                                        "Осталось",
                                                        style: small,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: element.value
                                                      .getSkillsByLevel(
                                                          element.value.level)!
                                                      .spellSlots
                                                      !.entries
                                                      .map((e) => Column(
                                                            children: [
                                                              Padding(
                                                                padding:  EdgeInsets.only(left: 6.w),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.spaceAround,
                                                                  children: [
                                                                    Text(
                                                                      e.key,
                                                                      style:
                                                                          small,
                                                                    ),
                                                                    Text(
                                                                      e.value
                                                                          .toString(),
                                                                      style:
                                                                          small,
                                                                    ),
                                                                    Container(
                                                                        height:
                                                                            4.h,
                                                                        width:
                                                                            15.w,
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal: 10
                                                                                .dp,
                                                                            vertical: 2
                                                                                .dp),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          border: Border.all(
                                                                              color:
                                                                                  OurColors.focusColorLight),
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              TextFormField(
                                                                                // onTapOutside: (event) {
                                                                                //   FocusManager.instance.primaryFocus
                                                                                //       ?.unfocus();
                                                                                //   if(e.value.toString()!=globalSpells[element
                                                                                //       .value
                                                                                //       .name]?[int.parse(
                                                                                //       e.key) -
                                                                                //       1].text) {
                                                                                //     saveCharacterInfo();
                                                                                //   }
                                                                                // },
                                                                                // onChanged:(event){
                                                                                //   if(e.value.toString()!=globalSpells[element
                                                                                //       .value
                                                                                //       .name]?[int.parse(
                                                                                //       e.key) -
                                                                                //       1].text) {
                                                                                //     saveCharacterInfo();
                                                                                //   }},
                                                                                // onEditingComplete: (){
                                                                                //   if(e.value.toString()!=globalSpells[element
                                                                                //       .value
                                                                                //       .name]?[int.parse(
                                                                                //       e.key) -
                                                                                //       1].text) {
                                                                                //     saveCharacterInfo();
                                                                                //   }},

                                                                            //initialValue: e.value.toString(),
                                                                            controller: globalSpells[element
                                                                                .value
                                                                                .name]?[int.parse(
                                                                                    e.key) -
                                                                                1],
                                                                            style: Theme.of(context)
                                                                                .textTheme
                                                                                .bodySmall,
                                                                            inputFormatters: [
                                                                              FilteringTextInputFormatter.digitsOnly,
                                                                              LengthLimitingTextInputFormatter(2),
                                                                            ],
                                                                            cursorColor:
                                                                                Colors.black45,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            textAlignVertical:
                                                                                TextAlignVertical.center,
                                                                            autofocus:
                                                                                false,
                                                                            decoration: InputDecoration(
                                                                                enabledBorder: const UnderlineInputBorder(
                                                                                  borderSide: BorderSide(style: BorderStyle.none),
                                                                                ),
                                                                                focusedBorder: const UnderlineInputBorder(
                                                                                  borderSide: BorderSide(style: BorderStyle.none),
                                                                                ),
                                                                                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black45)),
                                                                          ),
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 1.h,
                                                              )
                                                            ],
                                                          ))
                                                      .toList(),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                                .toList()),
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
                                                    padding:
                                                        EdgeInsets.all(5.dp),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        // SizedBox(width: 2.w),
                                                        element.key == 0
                                                            ? Text(
                                                                element.value)
                                                            : Text(
                                                                "${element.value} уровень"),
                                                        SizedBox(width: 10.w),
                                                        Container(
                                                          width: 24.dp,
                                                          height: 24.dp,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 1),
                                                          ),
                                                          child: Theme(
                                                            data: ThemeData(
                                                                unselectedWidgetColor:
                                                                    Colors
                                                                        .white),
                                                            child: Checkbox(
                                                              checkColor:
                                                                  Colors.black,
                                                              activeColor: Colors
                                                                  .transparent,
                                                              tristate: false,
                                                              value: checks[
                                                                  element.key],
                                                              onChanged: (bool?
                                                                  value) {
                                                                setState(() {
                                                                  checks[element
                                                                          .key] =
                                                                      value!;

                                                                  characterBloc.add(DeleteAllSelectedSpellsEvent());
                                                                  checks
                                                                      .asMap()
                                                                      .entries
                                                                      .forEach(
                                                                          (i) {
                                                                    if (i.value ==
                                                                        true) {
                                                                      characterBloc.state.characters[index]
                                                                          .knownSpells
                                                                          .asMap()
                                                                          .entries
                                                                          .forEach(
                                                                              (j) {
                                                                        if (j.value.level ==
                                                                            i.key) {
                                                                          characterBloc.add(AddSelectedSpellEvent(j.value));
                                                                        }
                                                                      });
                                                                    }
                                                                  });
                                                                    globalChecks=checks;
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
                        SizedBox(height: 4.w,),
                        Column(
                          children: characterBloc.state.currentSpells
                              .asMap()
                              .entries
                              .map((e) => Padding(
                                    padding: EdgeInsets.only(left: 2.w,right: 2.w,bottom: 1.h),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                                  children: e.value
                                                      .spellComponents.entries
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
                  ),
                ]),
              );
      },
    );
  }
}
