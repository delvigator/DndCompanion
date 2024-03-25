class Characteristics {
   List<CharacteristicUnit> characteristics;


changeSkillByName(String name){
  Skill? skill;
  for (var element in characteristics) {
    skill= element.getSkillByName(name);
    if(skill!=null) skill.mastery=!(skill.mastery);
  }

}
   setCharacteristicByName(String name, int number){
     for (var element in characteristics) {
       if(element.name==name) element.value=number;

     }
   }
  Characteristics({required this.characteristics});
  factory Characteristics.fromJson (List<dynamic> json){
    return Characteristics(characteristics:  List<CharacteristicUnit>.generate(
        json.length, (index) => CharacteristicUnit.fromJson(json[index])));
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
}

class Skill {
  final String name;
   bool mastery;

  Skill({required this.name, required this.mastery});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(name: json["name"], mastery: json["mastery"]);
  }
}
