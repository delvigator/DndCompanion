import 'package:dnd/models/skills_data.dart';

import '../components/skills.dart';

class Characteristics{
  final int strength;
  final int dexterity; //Ловкость
  final int constitution; //Телосложение
  final int charisma;
  final int intelligence;
  final int wisdom;
  final SkillsData skillsData;

  Characteristics(this.strength, this.dexterity, this.constitution,
      this.charisma, this.intelligence, this.wisdom, this.skillsData);
}