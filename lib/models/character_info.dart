class CharacterInfo{
  final int currentHealth;
  final int allHealth;
  final int tempHealth;
  final int speed;
  final int armorClass;
  final int experiencePoints;

  CharacterInfo({required this.currentHealth, required this.allHealth, required this.tempHealth, required this.speed,
      required this.armorClass, required this.experiencePoints});
  factory CharacterInfo.fromJson(Map<String,dynamic> json){
    return CharacterInfo(currentHealth: json["currentHealth"],
        allHealth: json["allHealth"],
        tempHealth: json["tempHealth"],
        speed: json["speed"],
        armorClass: json["armorClass"],
        experiencePoints: json["experiencePoints"]);

  }

}