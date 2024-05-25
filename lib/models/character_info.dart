import 'package:flutter/cupertino.dart';

class CharacterInfo{
  final int currentHealth;
  int allHealth;
  final int tempHealth;
  final int speed;
  final int armorClass;
   int experiencePoints;
  final int initiative;
  final int mastery;

  Map<String, dynamic> toJson() {
    return {
      "mastery":mastery,
      "currentHealth": currentHealth,
      "allHealth": allHealth,
      "tempHealth": tempHealth,
      "speed": speed,
      "armorClass": armorClass,
      "experiencePoints": experiencePoints,
      "initiative": initiative,
    };
  }

  CharacterInfo( {required this.initiative,required this.currentHealth, required this.allHealth,  required this.tempHealth, required this.speed,
      required this.armorClass, required this.experiencePoints, required this.mastery});
  factory CharacterInfo.fromJson(Map<String,dynamic> json){
    return CharacterInfo(
        currentHealth: json["currentHealth"],
        initiative: json["initiative"] ?? 0,
        allHealth: json["allHealth"],
        tempHealth: json["tempHealth"],
        speed: json["speed"],
        armorClass: json["armorClass"],
        experiencePoints: json["experiencePoints"],
      mastery:json["mastery"] ?? 2
    );

  }

  CharacterInfo copyWith({
    int? mastery,
    int? currentHealth,
    int? allHealth,
    int? tempHealth,
    int? speed,
    int? armorClass,
    int? experiencePoints,
    int? initiative,
  }) {
    return CharacterInfo(
      currentHealth: currentHealth ?? this.currentHealth,
      allHealth: allHealth ?? this.allHealth,
      tempHealth: tempHealth ?? this.tempHealth,
      speed: speed ?? this.speed,
      armorClass: armorClass ?? this.armorClass,
      experiencePoints: experiencePoints ?? this.experiencePoints,
      initiative: initiative ?? this.initiative,
      mastery: mastery ?? this.mastery,
    );
  }
}