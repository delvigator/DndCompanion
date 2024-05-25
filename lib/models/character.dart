import 'dart:convert';

import 'package:dnd/models/character_info.dart';
import 'package:dnd/models/characteristics.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'ch_class.dart';
import 'ch_race.dart';
import 'feature.dart';
import 'item.dart';
import 'magic_spell.dart';
import 'note.dart';

class Character extends Equatable {
  final int id;
  int level;
  final String name;
  final String description;
  final String? portrait;
  final ChRace chRace;
  final ChRace? subRace;
  final List<ChClass> chClass;
  final String ideology;
  final List<Feature> features;
  final Characteristics characteristics;
  final CharacterInfo characterInfo;
  final List<MagicSpell> knownSpells;
  final List<ItemInInventory> items;
  final List<Note> notes;

   Character(
      {
        this.id=-1,
        this.notes = const [],
        this.features=const [],
      this.items = const [],
      this.knownSpells = const [],
        required this.ideology,
      required this.subRace,
      required this.level,
      required this.name,
      this.portrait,
      required this.chRace,
      required this.chClass,
      required this.characteristics,
      required this.characterInfo,
      required this.description});

  ItemInInventory? getByItem(Item item) {
    ItemInInventory? result;
    for (var element in items) {
      if (element.item == item) result = element;
    }
    return result;
  }

  bool checkContainsItem(Item item) {
    bool cont = false;
    for (var e in items) {
      if (e.item == item) cont = true;
    }
    return cont;
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    List<dynamic> features =
    json["features"] is String? ? jsonDecode(json["features"]) : json["features"];
    List<dynamic> notes =
        json["notes"] is String? ? jsonDecode(json["notes"]) : json["notes"];
    List<dynamic> classes = json["chClass"] is String?
        ? jsonDecode(json["chClass"])
        : json["chClass"];
    List<dynamic> spells = json["selectedSpells"] is String?
        ? jsonDecode(json["selectedSpells"])
        : json["selectedSpells"];
    List<dynamic> items =
        json["items"] is String? ? jsonDecode(json["items"]) : json["items"];
    return Character(
        notes: List<Note>.generate(
            notes.length, (index) => Note.fromJson(notes[index])),
        level: json["level"],
        name: json["name"],
        id: json["id"] ?? -1,
        portrait: json["portrait"],
        chRace: json["chRace"] is String
            ? ChRace.fromJson(jsonDecode(json["chRace"]))
            : ChRace.fromJson(json["chRace"]),
        chClass: List<ChClass>.generate(
            classes.length, (index) => ChClass.fromJson(classes[index])),
        characteristics: Characteristics.fromJson(json["characteristics"]),
        characterInfo: CharacterInfo.fromJson(json["characterInfo"]),
        items: List<ItemInInventory>.generate(
            items.length, (index) => ItemInInventory.fromJson(items[index])),
        features: List<Feature>.generate(
            features.length, (index) => Feature.fromJson(features[index])),
        knownSpells: List<MagicSpell>.generate(
            spells.length, (index) => MagicSpell.fromJson(spells[index])),
        description: json["description"],
        ideology: json["ideology"],
        subRace: json["subRace"] is String && json["subRace"] != "null"
            ? ChRace.fromJson(jsonDecode(json["subRace"]))
            : json["subRace"] is Map
                ? ChRace.fromJson(json["subRace"])
                : null);
  }

  @override
  List<Object?> get props => [level, name];

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'features':features,
      'characteristics': characteristics,
      'ideology':ideology,
      'notes':jsonEncode(notes),
      'portrait': portrait,
      'level': level,
      'name': name,
      'description': description,
      'items': jsonEncode(items),
      'chRace': jsonEncode(chRace),
      'subRace': jsonEncode(subRace),
      'chClass': jsonEncode(chClass),

      'characterInfo': characterInfo.toJson(),
      'selectedSpells': jsonEncode(knownSpells),
    };
  }

  Character copyWith(
      {int? level,
        List<Feature>? features,
      String? name,
        String? ideology,
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
      List<ItemInInventory>? items,
        List<Note>? notes}) {
    return Character(
      ideology: ideology ?? this.ideology,
      features: features ?? this.features,
      notes: notes?? this.notes,
      level: level ?? this.level,
      name: name ?? this.name,
      description: description ?? this.description,
      portrait: portrait ?? this.portrait,
      chRace: chRace ?? this.chRace,
      subRace: subRace ?? this.subRace,
      chClass: chClass ?? this.chClass,
      items: items ?? this.items,
      characteristics: characteristics ?? this.characteristics,
      characterInfo: characterInfo ?? this.characterInfo,
      knownSpells: knownSpells ?? this.knownSpells,
    );
  }
}
