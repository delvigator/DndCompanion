import 'package:dnd/models/ch_class.dart';
import 'package:dnd/pages/character_selector/character_creation/skills_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../bloc/information_bloc/information_bloc.dart';
import '../../../components/default_button.dart';
import '../../../global_vars.dart';
import '../../../models/ch_race.dart';
List<String> simpleSkills = [];
class CreationFinal extends StatefulWidget {
  const CreationFinal({super.key});

  static String routeName = "/creationFinal";

  @override
  State<CreationFinal> createState() => _CreationFinalState();
}

class _CreationFinalState extends State<CreationFinal> {
  final TextEditingController descriptionController = TextEditingController();

  final maxLengthDescription = 300;
  final TextEditingController nameController = TextEditingController();
  final maxLengthName = 50;
  final TextEditingController ideologyController = TextEditingController();
  final maxLengthIdeology = 30;
  int currentPoints=0;
  final int maxPoints=27;
  Map<String,int> skills={
    "Сила":8,
    "Ловкость":8,
    "Телосложение":8,
    "Интеллект":8,
    "Мудрость":8,
    "Харизма":8
  };


  @override
  Widget build(BuildContext context) {

    TextStyle? whiteText = Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(color: Colors.white, fontSize: 11.dp);
    final args = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    ChRace currentRace = args["currentRace"];
    ChRace? currentSubRace = args["currentSubRace"];
    ChClass currentClass = args["currentClass"];
    List<String> simpleSkills=args["simpleSkills"] ?? [];

    return Scaffold(
        appBar: AppBar(
            title: const Text("Создание персонажа"),
            leading: const BackButton(
              color: Colors.white,
            )),
        body: BlocBuilder<InformationBloc, InformationState>(
            bloc: informationBloc,
            builder: (context, state) {
              informationBloc.add(LoadClassesEvent(context));
              return SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.all(20.dp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.dp),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextFormField(
                              buildCounter: (context,
                                      {required currentLength,
                                      required isFocused,
                                      maxLength}) =>
                                  const SizedBox(),
                              maxLength: maxLengthName,
                              controller: nameController,
                              style: Theme.of(context).textTheme.bodySmall,
                              cursorColor: Colors.black45,
                              textAlignVertical: TextAlignVertical.center,
                              autofocus: false,
                              decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  hintText: "Имя персонажа",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.black45)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.all(5.dp),
                            child: Text(
                              "${nameController.text.length}/$maxLengthName",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Container(
                            padding: EdgeInsets.all(10.dp),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextFormField(
                              controller: descriptionController,
                              maxLength: maxLengthDescription,
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              buildCounter: (context,
                                      {required currentLength,
                                      required isFocused,
                                      maxLength}) =>
                                  const SizedBox(),
                              style: Theme.of(context).textTheme.bodySmall,
                              cursorColor: Colors.black45,
                              textAlignVertical: TextAlignVertical.center,
                              autofocus: false,
                              maxLines: 10,
                              decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  hintText: "Описание персонажа",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.black45)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.all(5.dp),
                            child: Text(
                              "${descriptionController.text.length}/$maxLengthDescription",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.dp),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextFormField(
                              buildCounter: (context,
                                      {required currentLength,
                                      required isFocused,
                                      maxLength}) =>
                                  const SizedBox(),
                              maxLength: maxLengthIdeology,
                              controller: ideologyController,
                              style: Theme.of(context).textTheme.bodySmall,
                              cursorColor: Colors.black45,
                              textAlignVertical: TextAlignVertical.center,
                              autofocus: false,
                              decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  hintText: "Мировозрение",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.black45)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            padding: EdgeInsets.all(5.dp),
                            child: Text(
                              "${ideologyController.text.length}/$maxLengthIdeology",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.dp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                        text: "Класс: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white),
                                              text: currentClass.name)
                                        ])),
                                RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                        text: "Раса: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white),
                                              text: currentSubRace != null
                                                  ? "${currentRace.name}. ${currentSubRace.name}."

                                                  : currentRace.name)
                                        ])),
                                Padding(
                                  padding: currentSubRace==null ?  EdgeInsets.only(bottom: 30.dp) :  const EdgeInsets.only(bottom: 0),
                                  child: RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                          text: "Бонусы от расы: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          children: currentRace.skillBoost.entries.map((e) => TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                color: Colors.white),
                                            text: "${e.key}+${e.value} "
                                          )).toList(),
                                          )),
                                ),
                                currentSubRace !=null ?
                                Padding(
                                  padding:  EdgeInsets.only(bottom: 30.dp),
                                  child: RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        text: "Бонусы от разновидности: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        children: currentSubRace.skillBoost.entries.map((e) => TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                color: Colors.white),
                                            text: "${e.key}+${e.value} "
                                        )).toList(),

                                      )),
                                ) : Container(),

                                Table(
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  columnWidths:  const {
                                    0: IntrinsicColumnWidth(),
                                    1:IntrinsicColumnWidth(),
                                    3: FlexColumnWidth(),
                                    4: FlexColumnWidth()
                                  },
                                  children: [
                                    TableRow(
                                        children: [
                                      TableCell(
                                        child: Text(
                                          "Хар-ка",
                                          style: whiteText,
                                        ),
                                      ),
                                      TableCell(
                                          child: Center(
                                            child: Text(
                                        "Значение",
                                        style: whiteText,
                                      ),
                                          )),
                                      TableCell(
                                          child: Center(
                                            child: Text(
                                        "Мод.",
                                        style: whiteText,
                                      ),
                                          )),
                                      TableCell(
                                          child: Center(
                                            child: Text(
                                              "Итого",
                                              style: whiteText,
                                            ),
                                          ))
                                    ]),
                                    TableRow(children: [
                                      TableCell(
                                        child: Text(
                                          "Сила:",
                                          style: whiteText,
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              child: numberCounter("Сила", ()=>countPlus("Сила"), ()=>countMinus("Сила"))),
                                        )
                                      ),
                                      TableCell(child: Center(child: Text("${getMod("Сила")}",style: whiteText,))),
                                      TableCell(child: Center(child: Text((skills["Сила"]!+(currentRace.skillBoost["Сила"] ?? 0)+
                                          (currentSubRace?.skillBoost["Сила"] ?? 0)).toString(),style: whiteText,)))
                                    ]),
                                    TableRow(children: [
                                      TableCell(
                                        child: Text(
                                          "Ловкость:",
                                          style: whiteText,
                                        ),
                                      ),
                                      TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: numberCounter("Ловкость", ()=>countPlus("Ловкость"), ()=>countMinus("Ловкость"))),
                                          )
                                      ),
                                      TableCell(child: Center(child: Text("${getMod("Ловкость")}",style: whiteText,))),
                                      TableCell(child: Center(child: Text((skills["Ловкость"]!+(currentRace.skillBoost["Ловкость"] ?? 0)+
                                          (currentSubRace?.skillBoost["Ловкость"] ?? 0)).toString(),style: whiteText,)))
                                    ]),
                                    TableRow(children: [
                                      TableCell(
                                        child: Text(
                                          "Телосложение:",
                                          style: whiteText,
                                        ),
                                      ),
                                      TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: numberCounter("Телосложение", ()=>countPlus("Телосложение"), ()=>countMinus("Телосложение"))),
                                          )
                                      ),
                                      TableCell(child: Center(child: Text("${getMod("Телосложение")}",style: whiteText,))),
                                      TableCell(child: Center(child: Text((skills["Телосложение"]!+(currentRace.skillBoost["Телосложение"] ?? 0)+
                                          (currentSubRace?.skillBoost["Телосложение"] ?? 0)).toString(),style: whiteText,)))
                                    ]),
                                    TableRow(children: [
                                      TableCell(
                                        child: Text(
                                          "Интеллект:",
                                          style: whiteText,
                                        ),
                                      ),
                                      TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: numberCounter("Интеллект", ()=>countPlus("Интеллект"), ()=>countMinus("Интеллект"))),
                                          )
                                      ),
                                      TableCell(child: Center(child: Text("${getMod("Интеллект")}",style: whiteText,))),
                                      TableCell(child: Center(child: Text((skills["Интеллект"]!+(currentRace.skillBoost["Интеллект"] ?? 0)+
                                          (currentSubRace?.skillBoost["Интеллект"] ?? 0)).toString(),style: whiteText,)))
                                    ]),
                                    TableRow(children: [
                                      TableCell(
                                        child: Text(
                                          "Мудрость:",
                                          style: whiteText,
                                        ),
                                      ),
                                      TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: numberCounter("Мудрость", ()=>countPlus("Мудрость"), ()=>countMinus("Мудрость"))),
                                          )
                                      ),
                                      TableCell(child: Center(child: Text("${getMod("Мудрость")}",style: whiteText,))),
                                      TableCell(child: Center(child: Text((skills["Мудрость"]!+(currentRace.skillBoost["Мудрость"] ?? 0
                                          + (currentSubRace?.skillBoost["Мудрость"] ?? 0))).toString(),style: whiteText,)))
                                    ]),
                                    TableRow(children: [
                                      TableCell(
                                        child: Text(
                                          "Харизма:",
                                          style: whiteText,
                                        ),
                                      ),
                                      TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: numberCounter("Харизма", ()=>countPlus("Харизма"), ()=>countMinus("Харизма"))),
                                          )
                                      ),
                                      TableCell(child: Center(child: Text("${getMod("Харизма")}",style: whiteText,))),
                                      TableCell(child: Center(child: Text((skills["Харизма"]!+(currentRace.skillBoost["Харизма"] ?? 0)+
                                          (currentSubRace?.skillBoost["Харизма"] ?? 0)).toString(),style: whiteText,)))
                                    ])
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 3.dp),
                                  alignment: Alignment.topRight,
                                    child: Text("Осталось очков: $currentPoints/$maxPoints",style: Theme.of(context).textTheme.bodySmall?.copyWith(color:Colors.white),)),
                             Container(
                               padding: EdgeInsets.symmetric(vertical: 10.dp),
                               width: 40.w,
                               alignment: Alignment.topLeft,
                                 child: DefaultButton(text: 'Выбрать навыки',onPress: (){ Navigator.of(context).pushNamed(
                                     SkillsSelector.routeName, arguments: {
                                   "currentClass": currentClass
                                 });},)),
                                Container(
                                    width: 40.w,
                                    alignment: Alignment.topLeft,
                                    child: DefaultButton(text: 'Выбрать черты',onPress:(){Navigator.of(context).pushNamed(
                                        SkillsSelector.routeName);}) ,)
                              ],
                            ),
                          ),
                        ],
                      )));
            }));
  }
  int getMod(String skill){
    int number=(skills[skill]) ?? 8;
    int mod=((number-10)/2).floor();
    return mod;
  }
countPlus(String skill){
    int skillNumber=skills[skill] ?? -1;
    if(skillNumber!=-1 && currentPoints!=maxPoints){
      if(skillNumber>13 && currentPoints+2<=maxPoints){
          skillNumber++;
          currentPoints+=2;

      }
      else {
          skillNumber++;
          currentPoints++;

      }
    }
    if(skillNumber!=-1){
     skills[skill]=skillNumber;
    }
}
  countMinus(String skill){
    debugPrint(skill);
    int skillNumber=skills[skill] ?? -1;
    debugPrint(currentPoints.toString());
    if(skillNumber!=-1 && currentPoints!=0){
      if(skillNumber>13 && currentPoints-2>=0){

          skillNumber--;
          currentPoints-=2;

      }
      else {
          skillNumber--;
          currentPoints--;
      }
    }
    if(skillNumber!=-1) {
      skills[skill]=skillNumber;

    }
  }
  Widget numberCounter(String skill,VoidCallback onPressedPlus,VoidCallback onPressedMinus){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 4.h,
            width: 8.w,
            child: TextButton(
              onPressed: onPressedMinus,
              child: Icon(
                Icons.remove,
                color: Colors.black,
                size: 10.dp,
              ),
            ),
          ),
          Text(
           skills[skill].toString(),style: Theme.of(context).textTheme.bodySmall,
          ),
          Container(
            alignment: Alignment.center,
            height: 4.h,
            width: 8.w,
            child: TextButton(
              onPressed: onPressedPlus,
              child: Icon(Icons.add,
                  color: Colors.black,
                  size: 10.dp),
            ),
          ),
        ],
      ),
    );
  }
}

