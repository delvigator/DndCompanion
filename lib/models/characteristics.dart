import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Characteristics {
   List<CharacteristicUnit> characteristics;


changeSkillByName(String name){
  Skill? skill;
  for (var element in characteristics) {
    skill= element.getSkillByName(name);
    if(skill!=null) skill.mastery=!(skill.mastery);
  }

}
  int getCharacteristicByName(String name){
  int number=-1;
     for (var element in characteristics) {
       if(element.name==name) number= element.value;
     }
     return number;
   }
   setCharacteristicByName(String name, int number){
     for (var element in characteristics) {
       if(element.name==name) element.value=number;

     }
   }
  Characteristics({required this.characteristics});
  factory Characteristics.fromJson (Map<String,dynamic> json){
    List<dynamic> ch = json["characteristics"] is String? && json["characteristics"]!=null ? jsonDecode(json["characteristics"]) : json["characteristics"];
    return Characteristics(characteristics:  List<CharacteristicUnit>.generate(
        ch.length, (index) => CharacteristicUnit.fromJson(ch[index])));
  }

   Map<String, dynamic> toJson() {
    return {
      'characteristics': characteristics,
    };
  }


}

class CharacteristicUnit {
  final String name;
   int value;
   List<Skill> skills;

  Skill? getSkillByName(String name){
    Skill? result;
    for (var element in skills) {if(element.name==name) result=element;}
     return result;
   }
  CharacteristicUnit(
      {required this.name, required this.value, required this.skills});

  factory CharacteristicUnit.fromJson(Map<String, dynamic> json) {
    List<dynamic> skills = json["skills"];
    return CharacteristicUnit(
        name: json["name"],
        value: json["value"],
        skills: List<Skill>.generate(
            skills.length, (index) => Skill.fromJson(skills[index])));
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'skills': skills,
    };
  }


}

class Skill {
  final String name;
   bool mastery;

  Skill({required this.name, required this.mastery});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(name: json["name"], mastery: json["mastery"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mastery': mastery,
    };
  }


}
