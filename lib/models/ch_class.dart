import 'package:equatable/equatable.dart';

class ChClass extends Equatable {
  final String name;
  final int level;
  final ClassInfo classInfo;
  final List<ClassSkillsPerLevel> classSkillsPerLevel;
  final List<ClassSkillsText> classSkillsText;

  ClassSkillsPerLevel? getSkillsByLevel (int level){
    ClassSkillsPerLevel? result;

for (var element in classSkillsPerLevel) {
  if(element.level==level) {
    result=element;
  }
}
    return result;
  }

  const ChClass({
    required this.name,
    required this.level,
    required this.classInfo,
    required this.classSkillsPerLevel,
    required this.classSkillsText,
  });

  factory ChClass.fromJson(Map<String, dynamic> json) {
    List<dynamic> listSkills = json["classSkillsPerLevel"];
    List<dynamic> listText = json["classSkillsText"];
    return ChClass(
        name: json["name"],
        level: json["level"],
        classInfo: ClassInfo.fromJson(json["classInfo"]),
        classSkillsPerLevel: List<ClassSkillsPerLevel>.generate(
            listSkills.length,
            (index) => ClassSkillsPerLevel.fromJson(listSkills[index])),
        classSkillsText: List<ClassSkillsText>.generate(listText.length,
            (index) => ClassSkillsText.fromJson(listText[index])));
  }

  @override
  List<Object?> get props => [name];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'level': level,
      'classInfo': classInfo,
      'classSkillsPerLevel': classSkillsPerLevel,
      'classSkillsText': classSkillsText,
    };
  }


}

class ClassInfo {
  final int hitDice;
  final int startHealth;
  final String description;
  final List<String> saves;
  final List<String> simpleSkills;
  final int numberOfSimpleSkills;

  ClassInfo(
      {required this.hitDice,
        required this.description,
        required this.startHealth,
      required this.saves,
      required this.simpleSkills,
      required this.numberOfSimpleSkills});


  factory ClassInfo.fromJson(Map<String, dynamic> json) {
    List<dynamic> saves = json["saves"];
    List<dynamic> simpleSkills = json["simpleSkills"];
    return ClassInfo(
        hitDice: json["hitDice"],
        startHealth: json["startHealth"],
        saves: List<String>.generate(saves.length, (index) => saves[index]),
        simpleSkills: List<String>.generate(
            simpleSkills.length, (index) => simpleSkills[index]),
        numberOfSimpleSkills: json["numberOfSimpleSkills"],
        description: json["description"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'hitDice': hitDice,
      'startHealth': startHealth,
      'description': description,
      'saves': saves,
      'simpleSkills': simpleSkills,
      'numberOfSimpleSkills': numberOfSimpleSkills,
    };
  }


}

class ClassSkillsText {
  final String title;
  final String text;

  ClassSkillsText(
      { required this.title, required this.text});

  factory ClassSkillsText.fromJson(Map<String, dynamic> json) {
    return ClassSkillsText(
        title: json["title"] ?? "",
        text: json["text"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': text,
    };
  }


}

class ClassSkillUnit {
  final String skillName;
  final String skillDescription;

  ClassSkillUnit({required this.skillName, required this.skillDescription});

  factory ClassSkillUnit.fromJson(Map<String, dynamic> json) {
    return ClassSkillUnit(
        skillName: json["skillName"],
        skillDescription: json["skillDescription"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'skillName': skillName,
      'skillDescription': skillDescription,
    };
  }


}

class ClassSkillsPerLevel {
  final int level;
  final int masteryBonus;
  final List<ClassSkillUnit> classSkills;
  final int numberKnownSpells;
  final int numberKnownFocuses;
  final Map<String, int> spellSlots;


  ClassSkillsPerLevel(
      {required this.numberKnownFocuses,
      required this.level,
      required this.classSkills,
      required this.masteryBonus,
      required this.numberKnownSpells,
      required this.spellSlots});

  factory ClassSkillsPerLevel.fromJson(Map<String, dynamic> json) {
    List<dynamic> listUnits=json["classSkills"];
    return ClassSkillsPerLevel(
        numberKnownFocuses: json["numberKnownFocuses"],
        level: json["level"],
        masteryBonus: json['masteryBonus'],
        numberKnownSpells: json["numberKnownSpells"],
        spellSlots: Map<String,int>.from(json["spellSlots"]),
        classSkills: List<ClassSkillUnit>.generate(listUnits.length, (index) => ClassSkillUnit.fromJson(listUnits[index])));
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'masteryBonus': masteryBonus,
      'classSkills': classSkills,
      'numberKnownSpells': numberKnownSpells,
      'numberKnownFocuses': numberKnownFocuses,
      'spellSlots': spellSlots,

    };
  }


}
