import 'dart:convert';

import 'package:equatable/equatable.dart';

class MagicSpell extends Equatable{
  final String name;
  final String description;
  final String distance;
  final List<String> classes;
  final String school;
   final int level;
   final bool isRitual;
   final Map<String,bool> spellComponents;
   final String timeApplication;
  final String timeAction;

  const MagicSpell( {required this.name, required this.description, required this.distance, required this.classes,
      required this.school, required this.level, required this.isRitual, required this.spellComponents, required this.timeApplication,required this.timeAction,});

  factory MagicSpell.fromJson(Map<String,dynamic> json){
    List<dynamic> classes=json["classes"] is String ? jsonDecode(json["classes"]) : json["classes"];
    return MagicSpell(
        name: json["name"],
        description: json["description"],
        distance: json["distance"],
        classes: List.generate(classes.length, (index) => classes[index]),
        school: json["school"],
        level: json["level"],
        isRitual: json["ritual"],
        spellComponents: Map<String,bool>.from(json["spellComponents"]),
        timeApplication: json["timeApplication"], timeAction: json["timeAction"]);
  }

  @override
  List<Object?> get props => [name];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'distance': distance,
      'classes': classes,
      'school': school,
      'level': level,
      'ritual': isRitual,
      'spellComponents': spellComponents,
      'timeApplication': timeApplication,
      'timeAction': timeAction,

    };
  }


}