import 'package:dnd/components/skills.dart';
import 'package:dnd/models/ch_class.dart';
import 'package:dnd/models/ch_race.dart';
import 'package:dnd/models/character.dart';
import 'package:dnd/models/character_info.dart';
import 'package:dnd/models/skills_data.dart';

import 'bloc/character_bloc/character_bloc.dart';
import 'models/characteristics.dart';
import 'models/user_data.dart';

Character? currentCharacter;
CharacterBloc characterBloc = CharacterBloc();
UserData globalUserData= UserData(characters: [
  Character(1, 4, "Зублефар Зублефарович Зубрифалов", null, ChRace("Эльф"), [ChClass("Волшебник",10)], Characteristics(10,10,10,10,10,10,
  SkillsData(
      {StrengthSkills.save:true,
        StrengthSkills.athletics:false
      },{},{},{},{},{}
  )), CharacterInfo(3,10,4,25,10,6),'Описание персонажа'),

  Character(1, 4, "Зублефар Зублефарович", null, ChRace("Эльф"), [ChClass("Волшебник",8)], Characteristics(10,10,10,10,10,10,
      SkillsData(
          {StrengthSkills.save:true,
            StrengthSkills.athletics:false
          },{},{},{},{},{}
      )), CharacterInfo(3,10,4,25,10,6),'Описание персонажа'),

  Character(1, 4, "Зублефар Зублефарович", null, ChRace("Эльф"), [ChClass("Волшебник",7)], Characteristics(10,10,10,10,10,10,
      SkillsData(
          {StrengthSkills.save:true,
            StrengthSkills.athletics:false
          },{},{},{},{},{}
      )), CharacterInfo(3,10,4,25,10,6),'Описание персонажа'),

  Character(1, 4, "Зублефар Зублефарович", null, ChRace("Эльф"), [ChClass("Волшебник",5)], Characteristics(10,10,10,10,10,10,
      SkillsData(
          {StrengthSkills.save:true,
            StrengthSkills.athletics:false
          },{},{},{},{},{}
      )), CharacterInfo(3,10,4,25,10,6),'Описание персонажа'),
  Character(1, 4, "Зублефар Зублефарович", null, ChRace("Эльф"), [ChClass("Волшебник",3)], Characteristics(10,10,10,10,10,10,
      SkillsData(
          {StrengthSkills.save:true,
            StrengthSkills.athletics:false
          },{},{},{},{},{}
      )), CharacterInfo(3,10,4,25,10,6),'Описание персонажа'),
  Character(1, 4, "Зублефар Зублефарович", null, ChRace("Эльф"), [ChClass("Волшебник",4)], Characteristics(10,10,10,10,10,10,
      SkillsData(
          {StrengthSkills.save:true,
            StrengthSkills.athletics:false
          },{},{},{},{},{}
      )), CharacterInfo(3,10,4,25,10,6),'Описание персонажа'),
]);