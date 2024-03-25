import 'package:dnd/components/our_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../models/ch_class.dart';
import 'creation_final.dart';



class SkillsSelector extends StatefulWidget {
  const SkillsSelector({super.key});

  static String routeName = "/skillsSelector";

  @override
  State<SkillsSelector> createState() => _SkillsSelectorState();
}

class _SkillsSelectorState extends State<SkillsSelector> {
  int currentNumber = 0;
  List<String> result=[];
  late List<bool> values = [];
bool isChanged=false;
  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    ChClass currentClass = args["currentClass"];
    final int numberOfSkills = currentClass.classInfo.numberOfSimpleSkills;
    if (values.isEmpty) {
      values = List.generate(
          currentClass.classInfo.simpleSkills.length,
          (index) => simpleSkillsSelected.contains(currentClass.classInfo.simpleSkills[index])
              ? true
              : false);
      for (var element in values) {if(element==true) currentNumber++;}
      for (var element in simpleSkillsSelected) {
        if(!result.contains(element)) result.add(element);
      }
    }
    return Scaffold(
        appBar: AppBar(
            title: const Text("Навыки"),
            leading: const BackButton(
              color: Colors.white,
            )),
        floatingActionButton: FloatingActionButton(
            onPressed:  () {
              simpleSkillsSelected=List.from(result);} ,
            shape: const CircleBorder(),
            backgroundColor:  OurColors.focusColor,
            foregroundColor: Colors.black,
            child: const Icon(Icons.check)),
        body: StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.all(20.dp),
            child: Column(
              children: [
                Text(
                  "Выберите $numberOfSkills навыка, которым владеет ваш персонаж",
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
                      children: currentClass.classInfo.simpleSkills
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
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    value: values[e.key],
                                    onChanged: (bool? value) {
                                      debugPrint(value.toString());
                                      if (currentNumber < numberOfSkills &&
                                          value == true) {
                                        setState(() {
                                          isChanged=true;
                                          values[e.key] = value!;
                                        });
                                        currentNumber++;
                                        result.add(e.value);
                                      }
                                      debugPrint(currentNumber.toString());
                                      if (currentNumber > 0 && value == false) {
                                        setState(() {
                                          isChanged=true;
                                          values[e.key] = value!;
                                          currentNumber--;
                                          result.remove(e.value);
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
