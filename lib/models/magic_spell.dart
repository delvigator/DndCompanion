class MagicSpell{
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

  MagicSpell( {required this.name, required this.description, required this.distance, required this.classes,
      required this.school, required this.level, required this.isRitual, required this.spellComponents, required this.timeApplication,required this.timeAction,});

  factory MagicSpell.fromJson(Map<String,dynamic> json){
    List<dynamic> classes=json["classes"];
    return MagicSpell(
        name: json["name"],
        description: json["description"],
        distance: json["distance"],
        classes: List.generate(classes.length, (index) => classes[index]),
        school: json["school"],
        level: json["level"],
        isRitual: json["isRitual"],
        spellComponents: Map.from(json["spellComponents"]),
        timeApplication: json["timeApplication"], timeAction: json["timeAction"]);
  }
}