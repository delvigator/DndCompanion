import 'package:equatable/equatable.dart';

import 'characteristics.dart';

class ChRace extends Equatable {
  final String name;
  final String description;
  final List<ChRace> subRace;
  final List<Peculiarities> peculiarities; //особенности
  final List<Skill> skillMastery;
  final Map<String, int> skillBoost;
  final int numberFeatures;

// + заклинания которые добавляются с расой
  const ChRace(
      {
        required this.numberFeatures,
        required this.name,
      required this.subRace,
      required this.description,
      required this.peculiarities,
      required this.skillMastery,
      required this.skillBoost});

  factory ChRace.fromJson(Map<String, dynamic> json) {
    List<dynamic> peculiarities = json["peculiarities"];
    List<dynamic> skills = json["skillMastery"];
    List<dynamic> subRace = json["subRace"];
    return ChRace(
      name: json["name"],
      description: json["description"],
      peculiarities: List<Peculiarities>.generate(peculiarities.length,
          (index) => Peculiarities.fromJson(peculiarities[index])),
      skillMastery: List<Skill>.generate(
          skills.length, (index) => Skill.fromJson(skills[index])),
      skillBoost: Map<String, int>.from(json["skillBoost"]),
      subRace: List<ChRace>.generate(
          subRace.length, (index) => ChRace.fromJson(subRace[index])), numberFeatures: json["numberFeatures"],
    );
  }

  @override
  List<Object?> get props => [name,description,subRace];
}

class Peculiarities {
  final String title;
  final String text;

  Peculiarities({required this.title, required this.text});

  factory Peculiarities.fromJson(Map<String, dynamic> json) {
    return Peculiarities(title: json["title"], text: json["text"]);
  }
}
