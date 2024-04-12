import 'dart:convert';
import 'dart:io';
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
  final String? portrait;
  final ChRace chRace;
  final ChRace? subRace;
  final List<ChClass> chClass;
  final Characteristics characteristics;
  final CharacterInfo characterInfo;
  final List<MagicSpell> knownSpells;


  const Character(
      {
        this.knownSpells= const[],
        required this.subRace,
      required this.level,
      required this.name,
      this.portrait,
      required this.chRace,
      required this.chClass,
      required this.characteristics,
      required this.characterInfo,
      required this.description});

  factory Character.fromJson(Map<String, dynamic> json) {
    List<dynamic> classes = json["chClass"] is String? ? jsonDecode(json["chClass"]) : json["chClass"];
    List<dynamic> spells=json["selectedSpells"] is String? ? jsonDecode(json["selectedSpells"]) :  json["selectedSpells"];
    return Character(
        level: json["level"],
        name: json["name"],
        portrait: json["portrait"],
        chRace: json["chRace"] is String ? ChRace.fromJson(jsonDecode(json["chRace"])) : ChRace.fromJson(json["chRace"]),
        chClass: List<ChClass>.generate(
            classes.length, (index) => ChClass.fromJson(classes[index])),
        characteristics: Characteristics.fromJson(json["characteristics"]),
        characterInfo: CharacterInfo.fromJson(json["characterInfo"]),
        knownSpells: List<MagicSpell>.generate(spells.length, (index) => MagicSpell.fromJson(spells[index])),
        description: json["description"],
        subRace: json["subRace"] is  String && json["subRace"] !="null"  ? ChRace.fromJson(jsonDecode(json["subRace"])) : json["subRace"] is Map ? ChRace.fromJson(json["subRace"]) : null);
  }

  @override
  List<Object?> get props => [level, name];

  Map<String, dynamic> toJson() {
    return {
      'portrait': portrait,
      'level': level,
      'name': name,
      'description': description,
      'chRace': jsonEncode(chRace),
      'subRace': jsonEncode(subRace),
      'chClass': jsonEncode(chClass),
      'characteristics': characteristics,
      'characterInfo': characterInfo.toJson(),
      'selectedSpells':jsonEncode(knownSpells),
    };
  }

  Character copyWith({
    int? level,
    String? name,
    String? description,
    String? portrait,
    ChRace? chRace,
    ChRace? subRace,
    List<ChClass>? chClass,
    Characteristics? characteristics,
    CharacterInfo? characterInfo,
    List<MagicSpell>? knownSpells,
    List<dynamic>? classes,
    List<dynamic>? spells,
  }) {
    return Character(
      level: level ?? this.level,
      name: name ?? this.name,
      description: description ?? this.description,
      portrait: portrait ?? this.portrait,
      chRace: chRace ?? this.chRace,
      subRace: subRace ?? this.subRace,
      chClass: chClass ?? this.chClass,
      characteristics: characteristics ?? this.characteristics,
      characterInfo: characterInfo ?? this.characterInfo,
      knownSpells: knownSpells ?? this.knownSpells,
    );
  }
}
