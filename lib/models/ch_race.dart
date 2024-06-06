import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'characteristics.dart';

class ChRace extends Equatable {
  final String name;
  final String description;
  final bool isSubRace;
  final List<ChRace>? subRace;
  final List<Peculiarities> peculiarities; //особенности
  final List<Skill> skillMastery;
  final Map<String, int> skillBoost;
  final int numberFeatures;

// + заклинания которые добавляются с расой
  const ChRace(
      {
        required this.isSubRace,
        required this.numberFeatures,
        required this.name,
       this.subRace=const [],
      required this.description,
      required this.peculiarities,
      required this.skillMastery,
      required this.skillBoost});

  factory ChRace.fromJson(Map<String, dynamic> json) {
    List<dynamic> peculiarities = json["peculiarities"] is String ? jsonDecode(json["peculiarities"]) : json["peculiarities"];
    List<dynamic> skills = json["skillMastery"]is String ? jsonDecode(json["skillMastery"]) : json["skillMastery"];
    List<dynamic> subRace = json["subRace"]is String ? jsonDecode(json["subRace"]) : json["subRace"] ?? [];
    debugPrint(json["sub"].toString());
    return ChRace(
      isSubRace: json["sub"],
      name: json["name"],
      description: json["description"],
      peculiarities: List<Peculiarities>.generate(peculiarities.length,
          (index) => Peculiarities.fromJson(peculiarities[index])),
      skillMastery: List<Skill>.generate(
          skills.length, (index) => Skill.fromJson(skills[index])),
      skillBoost: json["skillBoost"] is String ? Map<String, int>.from(jsonDecode(json["skillBoost"])) : Map<String, int>.from(json["skillBoost"]),
      subRace: List<ChRace>.generate(
          subRace.length, (index) => ChRace.fromJson(subRace[index])), numberFeatures: json["numberFeatures"],
    );
  }

  @override
  List<Object?> get props => [name,description,subRace];

  Map<String, dynamic> toJson() {
    return {
      "sub":isSubRace,
      'name': name,
      'description': description,
      'subRace': subRace,
      'peculiarities': peculiarities,
      'skillMastery': skillMastery,
      'skillBoost': skillBoost,
      'numberFeatures': numberFeatures,
    };
  }


}

class Peculiarities extends Equatable {
  final String title;
  final String text;

  Peculiarities({required this.title, required this.text});

  factory Peculiarities.fromJson(Map<String, dynamic> json) {
    return Peculiarities(title: json["title"], text: json["text"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': text,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [title,text];


}
