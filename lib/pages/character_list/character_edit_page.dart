import 'dart:convert';

import 'package:dnd/bloc/character_bloc/character_bloc.dart';
import 'package:dnd/components/our_colors.dart';
import 'package:dnd/models/ch_class.dart';
import 'package:dnd/models/characteristics.dart';
import 'package:dnd/pages/character_selector/character_creation/creation_features.dart';
import 'package:dnd/pages/character_selector/character_creation/skills_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../bloc/information_bloc/information_bloc.dart';
import '../../../components/default_button.dart';
import '../../../global_vars.dart';
import '../../../models/ch_race.dart';
import '../../components/alert_dialog.dart';
import '../../components/snack_bar.dart';
import '../../models/character.dart';
import '../../models/feature.dart';
import '../../shared_prefs.dart';

List<String> simpleSkillsSelectedEdit = [];
List<String> selectedFeaturesEdit = [];

class CharacterEditPage extends StatefulWidget {
  const CharacterEditPage({super.key});

  static String routeName = "/characterEditPage";

  @override
  State<CharacterEditPage> createState() => _CharacterEditPageState();
}

class _CharacterEditPageState extends State<CharacterEditPage> {
  final TextEditingController descriptionController = TextEditingController();
  final maxLengthDescription = 300;
  final TextEditingController nameController = TextEditingController();
  final maxLengthName = 30;
  final TextEditingController ideologyController = TextEditingController();
  final TextEditingController healthController = TextEditingController();
  final maxLengthIdeology = 30;
  int currentPoints = 0;
  ChRace currentRace = characterBloc
      .state.characters[characterBloc.state.currentCharacter].chRace;
  ChRace? currentSubRace = characterBloc
      .state.characters[characterBloc.state.currentCharacter].subRace;
  List<ChClass> currentClass = characterBloc
      .state.characters[characterBloc.state.currentCharacter].chClass;
  static Characteristics characteristics = characterBloc
      .state.characters[characterBloc.state.currentCharacter].characteristics;

  // final int maxPoints = 27;
  Map<String, int> skills = {
    "Сила": characteristics.getCharacteristicByName("Сила"),
    "Ловкость": characteristics.getCharacteristicByName("Ловкость"),
    "Телосложение": characteristics.getCharacteristicByName("Телосложение"),
    "Интеллект": characteristics.getCharacteristicByName("Интеллект"),
    "Мудрость": characteristics.getCharacteristicByName("Мудрость"),
    "Харизма": characteristics.getCharacteristicByName("Харизма")
  };
  int ideologyIndex = -1;
  List<String> ideology = [
    "Законопослушный добрый",
    "Законопослушный нейтральный",
    "Законопослушный злой",
    "Нейтральный добрый",
    "Истинно нейтральный",
    "Нейтральный злой",
    "Хаотичный добрый",
    "Хаотичный нейтральный",
    "Хаотичный злой"
  ];

  @override
  void initState() {
    super.initState();
    ideologyController.text =
        characterBloc.state.characters[characterBloc.state.currentCharacter].ideology;
    ideologyIndex = ideology
        .indexOf(characterBloc.state.characters[characterBloc.state.currentCharacter].ideology);
    healthController.text = characterBloc
        .state.characters[characterBloc.state.currentCharacter].characterInfo.allHealth
        .toString();
    nameController.text =
        characterBloc.state.characters[characterBloc.state.currentCharacter].name;
    descriptionController.text =
        characterBloc.state.characters[characterBloc.state.currentCharacter].description;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: characterBloc,
      builder: (context, state) {
        int characterIndex = characterBloc.state.currentCharacter;
        characteristics = characterBloc.state
            .characters[characterBloc.state.currentCharacter].characteristics;
        // skills = {
        //   "Сила": characteristics.getCharacteristicByName("Сила"),
        //   "Ловкость": characteristics.getCharacteristicByName("Ловкость"),
        //   "Телосложение": characteristics.getCharacteristicByName("Телосложение"),
        //   "Интеллект": characteristics.getCharacteristicByName("Интеллект"),
        //   "Мудрость": characteristics.getCharacteristicByName("Мудрость"),
        //   "Харизма": characteristics.getCharacteristicByName("Харизма")
        // };
        if (selectedFeaturesEdit.isEmpty && simpleSkillsSelectedEdit.isEmpty) {
          for (var characteristic in characteristics.characteristicsList) {
            for (var skill in characteristic.skills) {
              if (skill.mastery) {
                simpleSkillsSelectedEdit.add(skill.name);
              }
            }
          }
          for (var feature
              in characterBloc.state.characters[characterIndex].features) {
            selectedFeaturesEdit.add(feature.name);
          }
        }
        TextStyle? whiteText = Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Colors.white, fontSize: 11.dp);
        final args = (ModalRoute.of(context)?.settings.arguments ??
            <String, dynamic>{}) as Map;

        // List<String> simpleSkills = args["simpleSkills"] ?? [];

        saveCharacter() async {
          String data = await DefaultAssetBundle.of(context)
              .loadString("assets/json/skillsStart.json");
          final result = jsonDecode(data);
          Characteristics ch = Characteristics.fromJson(result);
          skills.forEach((key, value) {
            ch.setCharacteristicByName(key, value);
          });
          for (var element in simpleSkillsSelectedEdit) {
            ch.changeSkillByName(element);
          }
          List<Feature> fea = [];
          for (var selected in selectedFeaturesEdit) {
            for (var all in informationBloc.state.features) {
              if (all.name == selected) fea.add(all);
            }
          }
          debugPrint(fea.length.toString());
          Character character = characterBloc.state.characters[characterIndex]
              .copyWith(
                  name: nameController.text,
                  ideology: ideology[ideologyIndex],
                  description: descriptionController.text,
                  characteristics: ch,
                  features: fea,
                  characterInfo: characterBloc
                      .state.characters[characterIndex].characterInfo
                      .copyWith(allHealth: int.parse(healthController.text)));
          characterBloc.add(ChangeCharacterEvent(character));

          simpleSkillsSelectedEdit = [];
          selectedFeaturesEdit = [];
        }

        return Scaffold(
            appBar: AppBar(
                title: const Text("Изменение персонажа"),
                leading: const BackButton(
                  color: Colors.white,
                )),
            body: BlocBuilder<CharacterBloc, CharacterState>(
              bloc: characterBloc,
              builder: (context, state) {
                return BlocBuilder<InformationBloc, InformationState>(
                    bloc: informationBloc,
                    builder: (context, state) {
                      informationBloc.add(LoadFeaturesEvent(context));
                      informationBloc.add(LoadClassesEvent(context));
                      return characterBloc.state.currentCharacter != -1
                          ? SingleChildScrollView(
                              child: Padding(
                                  padding: EdgeInsets.all(20.dp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.dp),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: TextFormField(
                                          buildCounter: (context,
                                                  {required currentLength,
                                                  required isFocused,
                                                  maxLength}) =>
                                              const SizedBox(),
                                          maxLength: maxLengthName,
                                          controller: nameController,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          cursorColor: Colors.black45,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              hintText: "Имя персонажа",
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Colors.black45)),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: TextFormField(
                                          controller: descriptionController,
                                          maxLength: maxLengthDescription,
                                          onTapOutside: (event) {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          buildCounter: (context,
                                                  {required currentLength,
                                                  required isFocused,
                                                  maxLength}) =>
                                              const SizedBox(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          cursorColor: Colors.black45,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          autofocus: false,
                                          maxLines: 10,
                                          decoration: InputDecoration(
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              hintText: "Описание персонажа",
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Colors.black45)),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.dp),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                child: ideologyIndex == -1
                                                    ? Text(
                                                        "Мировозрение",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .black45),
                                                      )
                                                    : Text(
                                                        ideology[ideologyIndex],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                              ),
                                              PopupMenuButton(
                                                color: OurColors.focusColorTile,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                  Radius.circular(20.0),
                                                )),
                                                icon: const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.black,
                                                ),
                                                itemBuilder:
                                                    (BuildContext context) =>
                                                        ideology
                                                            .asMap()
                                                            .entries
                                                            .map((e) =>
                                                                PopupMenuItem(
                                                                  child: Text(
                                                                    e.value,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodySmall
                                                                        ?.copyWith(
                                                                            color:
                                                                                Colors.white60),
                                                                  ),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      ideologyIndex =
                                                                          e.key;
                                                                    });
                                                                  },
                                                                ))
                                                            .toList(),
                                              ),
                                            ]),
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
                                        padding:
                                            EdgeInsets.symmetric(vertical: 4.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "Максимальные очки здоровья: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                            Container(
                                                height: 4.h,
                                                width: 15.w,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.dp,
                                                    vertical: 2.dp),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Center(
                                                  child: TextFormField(
                                                    controller:
                                                        healthController,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                      LengthLimitingTextInputFormatter(
                                                          3),
                                                    ],
                                                    cursorColor: Colors.black45,
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    autofocus: false,
                                                    decoration: InputDecoration(
                                                        enabledBorder:
                                                            const UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              style: BorderStyle
                                                                  .none),
                                                        ),
                                                        focusedBorder:
                                                            const UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              style: BorderStyle
                                                                  .none),
                                                        ),
                                                        hintStyle: Theme.of(
                                                                context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .black45)),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.dp),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                                textAlign: TextAlign.start,
                                                text: TextSpan(
                                                    text: "Классы: ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                    children: characterBloc
                                                        .state
                                                        .characters[
                                                            characterIndex]
                                                        .chClass
                                                        .map((e) => TextSpan(
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    color: Colors
                                                                        .white),
                                                            text: "${e.name} ${e.level} уровень. "))
                                                        .toList())),
                                            RichText(
                                                textAlign: TextAlign.start,
                                                text: TextSpan(
                                                    text: "Раса: ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            color: Colors.white,
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
                                                          text: currentSubRace !=
                                                                  null
                                                              ? "${currentRace.name}. ${currentSubRace?.name}."
                                                              : currentRace
                                                                  .name)
                                                    ])),
                                            Padding(
                                              padding: currentSubRace == null
                                                  ? EdgeInsets.only(
                                                      bottom: 30.dp)
                                                  : const EdgeInsets.only(
                                                      bottom: 0),
                                              child: RichText(
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                    text: "Бонусы от расы: ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                    children: currentRace
                                                        .skillBoost.entries
                                                        .map((e) => TextSpan(
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    color: Colors
                                                                        .white),
                                                            text:
                                                                "${e.key}+${e.value} "))
                                                        .toList(),
                                                  )),
                                            ),
                                            currentSubRace != null
                                                ? Padding(
                                                    padding:
                                                        simpleSkillsSelectedEdit
                                                                .isEmpty
                                                            ? EdgeInsets.only(
                                                                bottom: 30.dp)
                                                            : const EdgeInsets
                                                                    .only(
                                                                bottom: 0),
                                                    child: RichText(
                                                        textAlign:
                                                            TextAlign.start,
                                                        text: TextSpan(
                                                          text:
                                                              "Бонусы от разновидности: ",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          children: currentSubRace
                                                              ?.skillBoost
                                                              .entries
                                                              .map((e) => TextSpan(
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium
                                                                      ?.copyWith(
                                                                          color: Colors
                                                                              .white),
                                                                  text:
                                                                      "${e.key}+${e.value} "))
                                                              .toList(),
                                                        )),
                                                  )
                                                : Container(),
                                            simpleSkillsSelectedEdit.isNotEmpty
                                                ? Padding(
                                                    padding:
                                                        selectedFeaturesEdit
                                                                .isEmpty
                                                            ? EdgeInsets.only(
                                                                bottom: 30.dp)
                                                            : const EdgeInsets
                                                                    .only(
                                                                bottom: 0),
                                                    child: RichText(
                                                        textAlign:
                                                            TextAlign.start,
                                                        text: TextSpan(
                                                          text: "Навыки: ",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          children: simpleSkillsSelectedEdit
                                                              .asMap()
                                                              .entries
                                                              .map((e) => TextSpan(
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium
                                                                      ?.copyWith(
                                                                          color: Colors
                                                                              .white),
                                                                  text:
                                                                      "${e.value}. "))
                                                              .toList(),
                                                        )),
                                                  )
                                                : Container(),
                                            selectedFeaturesEdit.isNotEmpty
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 30.dp),
                                                    child: RichText(
                                                        textAlign:
                                                            TextAlign.start,
                                                        text: TextSpan(
                                                          text: "Черты: ",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          children: selectedFeaturesEdit
                                                              .asMap()
                                                              .entries
                                                              .map((e) => TextSpan(
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium
                                                                      ?.copyWith(
                                                                          color: Colors
                                                                              .white),
                                                                  text:
                                                                      "${e.value}. "))
                                                              .toList(),
                                                        )),
                                                  )
                                                : Container(),
                                            Table(
                                              defaultVerticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              columnWidths: const {
                                                0: IntrinsicColumnWidth(),
                                                1: IntrinsicColumnWidth(),
                                                3: FlexColumnWidth(),
                                                4: FlexColumnWidth()
                                              },
                                              children: [
                                                TableRow(children: [
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
                                                  // TableCell(
                                                  //     child: Center(
                                                  //       child: Text(
                                                  //         "Итого",
                                                  //         style: whiteText,
                                                  //       ),
                                                  //     ))
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        child: numberCounter(
                                                            "Сила",
                                                            () => countPlus(
                                                                "Сила"),
                                                            () => countMinus(
                                                                "Сила"))),
                                                  )),
                                                  TableCell(
                                                      child: Center(
                                                          child: Text(
                                                    "${getMod("Сила", currentRace, currentSubRace)}",
                                                    style: whiteText,
                                                  ))),
                                                  // TableCell(
                                                  //     child: Center(
                                                  //         child: Text(
                                                  //           (skills["Сила"]! +
                                                  //               (currentRace.skillBoost[
                                                  //               "Сила"] ??
                                                  //                   0) +
                                                  //               (currentSubRace?.skillBoost[
                                                  //               "Сила"] ??
                                                  //                   0))
                                                  //               .toString(),
                                                  //           style: whiteText,
                                                  //         )))
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        child: numberCounter(
                                                            "Ловкость",
                                                            () => countPlus(
                                                                "Ловкость"),
                                                            () => countMinus(
                                                                "Ловкость"))),
                                                  )),
                                                  TableCell(
                                                      child: Center(
                                                          child: Text(
                                                    "${getMod("Ловкость", currentRace, currentSubRace)}",
                                                    style: whiteText,
                                                  ))),
                                                  // TableCell(
                                                  //     child: Center(
                                                  //         child: Text(
                                                  //           (skills["Ловкость"]! +
                                                  //               (currentRace.skillBoost[
                                                  //               "Ловкость"] ??
                                                  //                   0) +
                                                  //               (currentSubRace?.skillBoost[
                                                  //               "Ловкость"] ??
                                                  //                   0))
                                                  //               .toString(),
                                                  //           style: whiteText,
                                                  //         )))
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        child: numberCounter(
                                                            "Телосложение",
                                                            () => countPlus(
                                                                "Телосложение"),
                                                            () => countMinus(
                                                                "Телосложение"))),
                                                  )),
                                                  TableCell(
                                                      child: Center(
                                                          child: Text(
                                                    "${getMod("Телосложение", currentRace, currentSubRace)}",
                                                    style: whiteText,
                                                  ))),
                                                  // TableCell(
                                                  //     child: Center(
                                                  //         child: Text(
                                                  //           (skills["Телосложение"]! +
                                                  //               (currentRace.skillBoost[
                                                  //               "Телосложение"] ??
                                                  //                   0) +
                                                  //               (currentSubRace?.skillBoost[
                                                  //               "Телосложение"] ??
                                                  //                   0))
                                                  //               .toString(),
                                                  //           style: whiteText,
                                                  //         )))
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        child: numberCounter(
                                                            "Интеллект",
                                                            () => countPlus(
                                                                "Интеллект"),
                                                            () => countMinus(
                                                                "Интеллект"))),
                                                  )),
                                                  TableCell(
                                                      child: Center(
                                                          child: Text(
                                                    "${getMod("Интеллект", currentRace, currentSubRace)}",
                                                    style: whiteText,
                                                  ))),
                                                  // TableCell(
                                                  //     child: Center(
                                                  //         child: Text(
                                                  //           (skills["Интеллект"]! +
                                                  //               (currentRace.skillBoost[
                                                  //               "Интеллект"] ??
                                                  //                   0) +
                                                  //               (currentSubRace?.skillBoost[
                                                  //               "Интеллект"] ??
                                                  //                   0))
                                                  //               .toString(),
                                                  //           style: whiteText,
                                                  //         )))
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        child: numberCounter(
                                                            "Мудрость",
                                                            () => countPlus(
                                                                "Мудрость"),
                                                            () => countMinus(
                                                                "Мудрость"))),
                                                  )),
                                                  TableCell(
                                                      child: Center(
                                                          child: Text(
                                                    "${getMod("Мудрость", currentRace, currentSubRace)}",
                                                    style: whiteText,
                                                  ))),
                                                  // TableCell(
                                                  //     child: Center(
                                                  //         child: Text(
                                                  //           (skills["Мудрость"]! +
                                                  //               (currentRace.skillBoost[
                                                  //               "Мудрость"] ??
                                                  //                   0 +
                                                  //                       (currentSubRace
                                                  //                           ?.skillBoost[
                                                  //                       "Мудрость"] ??
                                                  //                           0)))
                                                  //               .toString(),
                                                  //           style: whiteText,
                                                  //         )))
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        child: numberCounter(
                                                            "Харизма",
                                                            () => countPlus(
                                                                "Харизма"),
                                                            () => countMinus(
                                                                "Харизма"))),
                                                  )),
                                                  TableCell(
                                                      child: Center(
                                                          child: Text(
                                                    "${getMod("Харизма", currentRace, currentSubRace)}",
                                                    style: whiteText,
                                                  ))),
                                                  // TableCell(
                                                  //     child: Center(
                                                  //         child: Text(
                                                  //           (skills["Харизма"]! +
                                                  //               (currentRace.skillBoost[
                                                  //               "Харизма"] ??
                                                  //                   0) +
                                                  //               (currentSubRace?.skillBoost[
                                                  //               "Харизма"] ??
                                                  //                   0))
                                                  //               .toString(),
                                                  //           style: whiteText,
                                                  //         )))
                                                ])
                                              ],
                                            ),
                                            // Container(
                                            //     padding: EdgeInsets.symmetric(
                                            //         vertical: 3.dp),
                                            //     alignment: Alignment.topRight,
                                            //     child: Text(
                                            //       "Очков использовано: $currentPoints/$maxPoints",
                                            //       style: Theme.of(context)
                                            //           .textTheme
                                            //           .bodySmall
                                            //           ?.copyWith(color: Colors.white),
                                            //     )),
                                            Container(
                                                padding:
                                                    EdgeInsets.only(top: 30.dp),
                                                width: 40.w,
                                                alignment: Alignment.topLeft,
                                                child: DefaultButton(
                                                  text: 'Выбрать навыки',
                                                  onPress: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            SkillsSelector
                                                                .routeName,
                                                            arguments: {
                                                          "mod": 1,
                                                        });
                                                  },
                                                )),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(top: 10.dp),
                                              width: 40.w,
                                              alignment: Alignment.topLeft,
                                              child: DefaultButton(
                                                  text: 'Выбрать черты',
                                                  onPress: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            CreationFeatures
                                                                .routeName,
                                                            arguments: {
                                                          "mod": 1,
                                                        });
                                                  }),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(top: 40.dp),
                                              alignment: Alignment.topLeft,
                                              child: DefaultButton(
                                                  primaryColor:
                                                      OurColors.focusColorLight,
                                                  text: 'Сохранить',
                                                  onPress: () async {
                                                    if (nameController
                                                        .text.isEmpty) {
                                                      showSnackBar(
                                                          "Введите имя персонажа");
                                                    } else if(characterBloc.state.getByName(nameController.text)!=null &&
                                                       nameController.text!=characterBloc.state.characters[characterIndex].name ){
                                                      showSnackBar(
                                                          "Персонаж с таким именем уже существует");
                                                    }else if (ideologyIndex ==
                                                        -1) {
                                                      showSnackBar(
                                                          "Введите мировозрение персонажа");
                                                    } else if (healthController
                                                        .text.isEmpty) {
                                                      showSnackBar(
                                                          "Введите очки здоровья");
                                                    } else if (simpleSkillsSelectedEdit.isEmpty &&
                                                        healthController
                                                            .text.isNotEmpty &&
                                                        ideologyController
                                                            .text.isNotEmpty &&
                                                        nameController
                                                            .text.isNotEmpty) {
                                                      showMyDialog(
                                                          "Нет выбранных навыков",
                                                          "Вы уверены, что хотите продолжить?",
                                                          (context) {
                                                        saveCharacter();
                                                        Navigator.of(context)
                                                            .popUntil((route) =>
                                                                route.isFirst);
                                                        saveCharacterInfo();
                                                        saveInfo();
                                                      }, context);
                                                    } else if (selectedFeaturesEdit.isEmpty &&
                                                        healthController
                                                            .text.isNotEmpty &&
                                                        ideologyController
                                                            .text.isNotEmpty &&
                                                        nameController
                                                            .text.isNotEmpty) {
                                                      showMyDialog(
                                                          "Нет выбранных черт",
                                                          "Вы уверены, что хотите продолжить?",
                                                          (context) {
                                                        saveCharacter();
                                                        Navigator.of(context)
                                                            .popUntil((route) =>
                                                                route.isFirst);
                                                        saveCharacterInfo();
                                                        saveInfo();
                                                      }, context);
                                                    } else {
                                                      saveCharacter();
                                                      Navigator.of(context)
                                                          .popUntil((route) =>
                                                              route.isFirst);
                                                      saveCharacterInfo();
                                                      saveInfo();
                                                    }
                                                    //   String data =
                                                    //   await DefaultAssetBundle.of(
                                                    //       context)
                                                    //       .loadString(
                                                    //       "assets/json/skillsStart.json");
                                                    //   final result = jsonDecode(data);
                                                    //   Characteristics ch =
                                                    //   Characteristics.fromJson(
                                                    //       result);
                                                    //   skills.forEach((key, value) {
                                                    //     ch.setCharacteristicByName(
                                                    //         key, value);
                                                    //   });
                                                    //   for (var element
                                                    //   in simpleSkillsSelected) {
                                                    //     ch.changeSkillByName(element);
                                                    //   }
                                                    //   Character character = Character(
                                                    //       level: 1,
                                                    //       name: nameController.text,
                                                    //       chRace: currentRace,
                                                    //       chClass: [currentClass],
                                                    //       characteristics: ch,
                                                    //       characterInfo: CharacterInfo(
                                                    //
                                                    //           experiencePoints: 0,
                                                    //           currentHealth: int.parse(
                                                    //               healthController
                                                    //                   .text),
                                                    //           allHealth: int.parse(
                                                    //               healthController
                                                    //                   .text),
                                                    //           armorClass: 10 +
                                                    //               getMod(
                                                    //                   "Ловкость",
                                                    //                   currentRace,
                                                    //                   currentSubRace), initiative: 0, tempHealth: 0, speed: 30, mastery: 2),
                                                    //       description:
                                                    //       descriptionController
                                                    //           .text,
                                                    //       subRace:currentSubRace, knownSpells: const [] );
                                                    //   characterBloc
                                                    //       .add(AddCharacterEvent(character));
                                                    //   Navigator.of(context).popUntil((route) => route.isFirst);
                                                    //   saveCharacterInfo();
                                                    //   saveInfo();

                                                    // }
                                                  }),
                                            ),
                                            Center(
                                              child: TextButton(
                                                  onPressed: () {
                                                    showMyDialog(
                                                        "Вы уверены?",
                                                        "",
                                                        (context) => {
                                                          Navigator.of(
                                                              context)
                                                              .pop(),
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                              characterBloc.add(
                                                                  DeleteCurrentCharacterEvent())
                                                            },
                                                        context);
                                                  },
                                                  child: const Text(
                                                    "Удалить персонажа",
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )))
                          : Container();
                    });
              },
            ));
      },
    );
  }

  int getMod(String skill, ChRace currentRace, ChRace? currentSubRace) {
    int number = skills[skill] ?? -1;
    int mod = ((number - 10) / 2).floor();
    return mod;
  }

  countPlus(String skill) {
    int skillNumber = skills[skill] ?? -1;
    if (skillNumber != -1 && skillNumber != 20) {
      skillNumber++;
      skills[skill] = skillNumber;
    }
  }

  countMinus(String skill) {
    int skillNumber = skills[skill] ?? -1;
    if (skillNumber > 0) {
      skillNumber--;
      skills[skill] = skillNumber;
    }
  }

  Widget numberCounter(
      String skill, VoidCallback onPressedPlus, VoidCallback onPressedMinus) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
            skills[skill].toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Container(
            alignment: Alignment.center,
            height: 4.h,
            width: 8.w,
            child: TextButton(
              onPressed: onPressedPlus,
              child: Icon(Icons.add, color: Colors.black, size: 10.dp),
            ),
          ),
        ],
      ),
    );
  }
}
