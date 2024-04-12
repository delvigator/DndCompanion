import 'ch_race.dart';

class Feature{
  final String name;
  final String description;
  final List<Peculiarities> peculiarities;
  final Map<String,int> bonuses;

  Feature({required this.name, required this.description, required this.peculiarities, required this.bonuses});

  factory Feature.fromJson(Map<String,dynamic> json){
    List<dynamic> peculiarities = json["peculiarities"];
    return Feature(name: json["name"], description: json["description"], peculiarities: List<Peculiarities>.generate(peculiarities.length,
            (index) => Peculiarities.fromJson(peculiarities[index])), bonuses: Map.from(json["bonuses"]));
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'peculiarities': peculiarities,
      'bonuses': bonuses,

    };
  }


}