class Characteristics {
  final CharacteristicUnit strength;
  final CharacteristicUnit dexterity;
  final CharacteristicUnit constitution;
  final CharacteristicUnit charisma;
  final CharacteristicUnit intelligence;
  final CharacteristicUnit wisdom;

  Characteristics({required this.strength, required this.dexterity, required this.constitution,
      required this.charisma, required this.intelligence, required this.wisdom});
  factory Characteristics.fromJson (Map<String,dynamic> json){
    return Characteristics(strength: CharacteristicUnit.fromJson(json["strength"]),
        dexterity: CharacteristicUnit.fromJson(json["dexterity"]),
        constitution: CharacteristicUnit.fromJson(json["constitution"]),
        charisma: CharacteristicUnit.fromJson(json["charisma"]),
        intelligence: CharacteristicUnit.fromJson(json["intelligence"]),
        wisdom: CharacteristicUnit.fromJson(json["wisdom"]));
  }
}

class CharacteristicUnit {
  final String name;
  final int value;
  final List<Skill> skills;

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
  final bool mastery;

  Skill({required this.name, required this.mastery});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(name: json["name"], mastery: json["mastery"]);
  }
}
