
import 'characteristics.dart';

class ChRace{
final String name;
final String description;
final List<Peculiarities> peculiarities; //особенности
final List<Skill> skillMastery;
final Map<String,int> skillBoost;
// + заклинания которые добавляются с классом
ChRace({required this.name, required this.description, required this.peculiarities, required this.skillMastery,
    required this.skillBoost});

factory ChRace.fromJson(Map<String,dynamic> json){
  List<dynamic> peculiarities=json["peculiarities"];
  List<dynamic> skills=json["skillMastery"];
    return ChRace(name: json["name"],
  description: json["description"],
        peculiarities: List<Peculiarities>.generate(peculiarities.length, (index) => Peculiarities.fromJson(peculiarities[index])),
        skillMastery: List<Skill>.generate(skills.length, (index) => Skill.fromJson(skills[index])),
        skillBoost: Map<String,int>.from(json ["skillBoost"]));
}
}

class Peculiarities{
  final String title;
  final String text;

  Peculiarities({required this.title, required this.text});
  factory Peculiarities.fromJson(Map<String,dynamic> json){
    return Peculiarities(title: json["title"], text: json["text"]);
  }
}