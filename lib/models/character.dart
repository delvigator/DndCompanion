import 'dart:ui';

import 'package:dnd/models/character_info.dart';
import 'package:dnd/models/characteristics.dart';
import 'package:equatable/equatable.dart';

import 'ch_class.dart';
import 'ch_race.dart';

class Character extends Equatable {

  final int level;
  final String name;
  final String description;
  final Image? portrait;
  final ChRace chRace;
  final List<ChClass> chClass;
  final Characteristics characteristics;
  final CharacterInfo characterInfo;

  const Character(
      {
        required this.level,
      required this.name,
      this.portrait,
      required this.chRace,
      required this.chClass,
      required this.characteristics,
      required this.characterInfo,
      required this.description});

  factory Character.fromJson(Map<String, dynamic> json) {
    List<dynamic> classes = json["chClass"];
    return Character(
        level: json["level"],
        name: json["name"],
        chRace: ChRace.fromJson(json["chRace"]),
        chClass: List<ChClass>.generate(
            classes.length, (index) => ChClass.fromJson(classes[index])),
        characteristics: Characteristics.fromJson(json["characteristics"]),
        characterInfo: CharacterInfo.fromJson(json["characterInfo"]),
        description: json["description"]);
  }

  @override
  List<Object?> get props => [level,name];




}
