import 'dart:convert';


class Characteristics {
   List<CharacteristicUnit> characteristicsList;

changeSkillByName(String name){
  Skill? skill;
  for (var element in characteristicsList) {
    skill= element.getSkillByName(name);
    if(skill!=null) skill.mastery=!(skill.mastery);
  }

}
CharacteristicUnit? getChUnitByName(String name){
  CharacteristicUnit? chUnit;
  for (var element in characteristicsList) {
   if(element.name==name) chUnit=element;
  }
  return chUnit;
}
  int getCharacteristicByName(String name){
  int number=-1;
     for (var element in characteristicsList) {
       if(element.name==name) number= element.value;
     }
     return number;
   }
   setCharacteristicByName(String name, int number){
     for (var element in characteristicsList) {
       if(element.name==name) element.value=number;

     }
   }
  Characteristics({required this.characteristicsList});
  factory Characteristics.fromJson (Map<String,dynamic> json){
    List<dynamic> ch = json["characteristicsList"] is String? && json["characteristicsList"]!=null ? jsonDecode(json["characteristicsList"]) : json["characteristicsList"];
    return Characteristics(characteristicsList:  List<CharacteristicUnit>.generate(
        ch.length, (index) => CharacteristicUnit.fromJson(ch[index])));
  }

   Map<String, dynamic> toJson() {
    return {
      'characteristicsList': characteristicsList,
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
