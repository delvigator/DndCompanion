class CharacterInfo{
  final int currentHealth;
  final int allHealth;
  final int tempHealth;
  final int speed;
  final int armorClass;
  final int experiencePoints;

  CharacterInfo({required this.currentHealth, required this.allHealth,  this.tempHealth=0, this.speed=30,
      required this.armorClass, this.experiencePoints=0});
  factory CharacterInfo.fromJson(Map<String,dynamic> json){
    return CharacterInfo(currentHealth: json["currentHealth"],
        allHealth: json["allHealth"],
        tempHealth: json["tempHealth"],
        speed: json["speed"],
        armorClass: json["armorClass"],
        experiencePoints: json["experiencePoints"]);

  }

}