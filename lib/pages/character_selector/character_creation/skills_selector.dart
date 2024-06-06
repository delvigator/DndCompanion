import 'package:dnd/components/our_colors.dart';
import 'package:dnd/global_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../models/ch_class.dart';
import '../../../models/characteristics.dart';
import '../../character_list/character_edit_page.dart';
import 'creation_final.dart';

class SkillsSelector extends StatefulWidget {
  const SkillsSelector({super.key});

  static String routeName = "/skillsSelector";

  @override
  State<SkillsSelector> createState() => _SkillsSelectorState();
}

class _SkillsSelectorState extends State<SkillsSelector> {
  int currentNumber = 0;
  List<Skill> allSkills = [];
  List<String> result = [];
  late List<bool> values = [];
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    ChClass? currentClass = args["currentClass"];
    //0-создание, 1- изменение
    int mod = args["mod"];

    final int? numberOfSkills = currentClass?.numberOfSimpleSkills;
    if (values.isEmpty) {
      if (mod == 0) {
        values = List.generate(
            currentClass!.simpleSkills.length,
            (index) => simpleSkillsSelected
                    .contains(currentClass.simpleSkills[index])
                ? true
                : false);
        for (var element in values) {
          if (element == true) currentNumber++;
        }
        for (var element in simpleSkillsSelected) {
          if (!result.contains(element)) result.add(element);
        }
      } else {
        for (var characteristic in characterBloc
            .state
            .characters[characterBloc.state.currentCharacter]
            .characteristics
            .characteristicsList) {
          for (var skill in characteristic.skills) {
            allSkills.add(skill);
          }
        }
        values = List.generate(
            allSkills.length,
            (index) => simpleSkillsSelectedEdit.contains(allSkills[index].name)
                ? true
                : false);
        for (var element in simpleSkillsSelectedEdit) {
          if (!result.contains(element)) result.add(element);
        }
      }
    }
    return Scaffold(
        appBar: AppBar(
            title: const Text("Навыки"),
            leading: const BackButton(
              color: Colors.white,
            )),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              mod==0?
              simpleSkillsSelected = List.from(result) : simpleSkillsSelectedEdit=List.from(result);
              result=[];
              Navigator.of(context).pop();

            },
            shape: const CircleBorder(),
            backgroundColor: OurColors.focusColorLight,
            foregroundColor: Colors.black,
            child: const Icon(Icons.check)),
        body: StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.all(20.dp),
            child: Column(
              children: [
                mod == 0
                    ? Text(
                        "Выберите $numberOfSkills навыка, которым владеет ваш персонаж",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white),
                      )
                    : Text(
                        "Выберите навыки, которыми владеет ваш персонаж",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                SizedBox(
                  height: 4.h,
                ),
                Expanded(
                  child: ListView(
                      children: mod == 0
                          ? currentClass!.simpleSkills
                              .asMap()
                              .entries
                              .map((e) => Padding(
                                    padding: EdgeInsets.all(5.dp),
                                    child: Container(
                                      padding: EdgeInsets.all(3.dp),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: CheckboxListTile(
                                        checkboxShape: const CircleBorder(),
                                        activeColor: OurColors.focusColor,
                                        title: Text(
                                          e.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        value: values[e.key],
                                        onChanged: (bool? value) {
                                          debugPrint(value.toString());
                                          if (currentNumber < numberOfSkills! &&
                                              value == true) {
                                            setState(() {
                                              isChanged = true;
                                              values[e.key] = value!;
                                            });
                                            currentNumber++;
                                            result.add(e.value);
                                          }
                                          debugPrint(currentNumber.toString());
                                          if (currentNumber > 0 &&
                                              value == false) {
                                            setState(() {
                                              isChanged = true;
                                              values[e.key] = value!;
                                              currentNumber--;
                                              result.remove(e.value);
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ))
                              .toList()
                          : allSkills
                              .asMap()
                              .entries
                              .map((e) => Padding(
                                    padding: EdgeInsets.all(5.dp),
                                    child: Container(
                                      padding: EdgeInsets.all(3.dp),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: CheckboxListTile(
                                        checkboxShape: const CircleBorder(),
                                        activeColor: OurColors.focusColor,
                                        title: Text(
                                          e.value.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        value: values[e.key],
                                        onChanged: (bool? value) {
                                          debugPrint(value.toString());
                                          if (
                                              value == true) {
                                            setState(() {
                                              isChanged = true;
                                              values[e.key] = value!;
                                            });
                                            result.add(e.value.name);
                                          }
                                          debugPrint(currentNumber.toString());
                                          if (value == false) {
                                            setState(() {
                                              isChanged = true;
                                              values[e.key] = value!;
                                              currentNumber--;
                                              result.remove(e.value.name);
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ))
                              .toList()),
                ),
              ],
            ),
          );
        }));
  }
}
