import 'dart:ui';

import 'package:dnd/models/character_info.dart';
import 'package:dnd/models/characteristics.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'ch_class.dart';
import 'ch_race.dart';
import 'magic_spell.dart';

class Character extends Equatable {
  final int level;
  final String name;
  final String description;
  final Image? portrait;
  final ChRace chRace;
  final List<ChClass> chClass;
  final Characteristics characteristics;
  final CharacterInfo characterInfo;
  final List<MagicSpell> selectedSpells;

  const Character(
      {this.selectedSpells = const [],
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
    List<dynamic> spells=json["selectedSpells"] ?? [];
    debugPrint(spells.length.toString());
    return Character(
        level: json["level"],
        name: json["name"],
        chRace: ChRace.fromJson(json["chRace"]),
        chClass: List<ChClass>.generate(
            classes.length, (index) => ChClass.fromJson(classes[index])),
        characteristics: Characteristics.fromJson(json["characteristics"]),
        characterInfo: CharacterInfo.fromJson(json["characterInfo"]),
        selectedSpells: List<MagicSpell>.generate(spells.length, (index) => MagicSpell.fromJson(spells[index])),
        description: json["description"]);
  }

  @override
  List<Object?> get props => [level, name];
}
