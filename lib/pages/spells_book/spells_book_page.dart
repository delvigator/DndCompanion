import 'package:dnd/bloc/character_bloc/character_bloc.dart';
import 'package:dnd/global_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../components/our_colors.dart';
import '../../models/character.dart';
import '../../models/magic_spell.dart';

class SpellsBookPage extends StatefulWidget {
  const SpellsBookPage({super.key});

  @override
  State<SpellsBookPage> createState() => _SpellsBookPageState();
}

class _SpellsBookPageState extends State<SpellsBookPage> {
  Map<String, List<TextEditingController>> spells = globalSpells;
  List<String> levels = List.generate(
      10, (index) => index == 0 ? "Фокус" : (index - 1).toString());
  List<bool> checks = [];
  List<MagicSpell> currentSpells = [];

  @override
  Widget build(BuildContext context) {
    if (globalChecks.isEmpty) {
      checks =
          List.generate(levels.length, (index) => index == 0 ? true : false);
      globalChecks = checks;
    } else {
      checks = globalChecks;
    }

    TextStyle? small = Theme.of(context).textTheme.bodySmall;
    TextStyle? verySmall = Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.dp);
    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: characterBloc,
      builder: (context, state) {
        Character? character = characterBloc.state.currentCharacter;
        if (character != null && spells.isEmpty) {
          for (var element in character.chClass) {
            spells.putIfAbsent(element.name,
                () => List.generate(9, (index) => TextEditingController()));
            spells[element.name]?.asMap().forEach((key, value) {
              value.text = element
                  .getSkillsByLevel(character.level)!
                  .spellSlots[(key + 1).toString()]
                  .toString();
            });
          }
          globalSpells = spells;
        }
        if (currentSpells.isEmpty && character != null) {
          checks.asMap().entries.forEach((i) {
            if(i.value==true) {
              character.selectedSpells
                  .asMap()
                  .entries
                  .forEach((j) {
                if(j.value.level==i.key ){
                  currentSpells.add(j.value);
                }
              });
            }
          });
        }
        return character == null
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Column(
                        children: [
                          Column(
                              children: character.chClass
                                  .asMap()
                                  .entries
                                  .map((element) => Card(
                                        color: OurColors.focusColor,
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                                                    children: element.value
                                                        .getSkillsByLevel(
                                                            element
                                                                .value.level)!
                                                        .spellSlots
                                                        .entries
                                                        .map((e) => Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
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
                                                                        width: 15
                                                                            .w,
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal: 10
                                                                                .dp,
                                                                            vertical: 2
                                                                                .dp),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          border:
                                                                              Border.all(color: OurColors.focusColorLight),
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              TextFormField(
                                                                            //initialValue: e.value.toString(),
                                                                            controller:
                                                                                spells[element.value.name]?[int.parse(e.key) - 1],
                                                                            style:
                                                                                Theme.of(context).textTheme.bodySmall,
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
                                  backgroundColor:
                                      OurColors.focusColorTileLight,
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
                                                            MainAxisAlignment
                                                                .end,
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
                                                                    Colors
                                                                        .black,
                                                                activeColor: Colors
                                                                    .transparent,
                                                                tristate: false,
                                                                value: checks[
                                                                    element
                                                                        .key],
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    checks[element
                                                                            .key] =
                                                                        value!;


                                                                      currentSpells = [];
                                                                      checks.asMap().entries.forEach((i) {
                                                                        if(i.value==true) {
                                                                          character.selectedSpells
                                                                              .asMap()
                                                                              .entries
                                                                              .forEach((j) {
                                                                            if(j.value.level==i.key ){
                                                                              currentSpells.add(j.value);
                                                                            }
                                                                          });
                                                                        }
                                                                      });

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
                          Column(
                            children: currentSpells
                                .asMap()
                                .entries
                                .map((e) => 
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 2.w),
                                  child: Container(
                                    padding: EdgeInsets.all(15.dp),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                              ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [Text(e.value.name),
                                              Text(e.value.school,style: verySmall,),
                                                Text(e.value.timeApplication,style: verySmall,)],

                                            ),
                                            Column(
                                              children: [
                                                e.value.level == 0
                                                    ? Text("Фокус",style: small,)
                                                    : Text(
                                                        "${e.value.level} уровень",style: small,),
                                                Row(
                                                  children: e.value.spellComponents.entries.map((comp) =>  Text("${comp.key}. ",style: small,) ).toList(),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                ))
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              );
      },
    );
  }
}
