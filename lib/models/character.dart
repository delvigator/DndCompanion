import 'dart:ui';

import 'package:dnd/models/character_info.dart';
import 'package:dnd/models/characteristics.dart';

import 'ch_class.dart';
import 'ch_race.dart';

class Character {
  final int id;
  final int level;
  final String name;
  final String description;
  final Image? portrait;
  final ChRace chRace;
  final List<ChClass> chClass;
  final Characteristics characteristics;
  final CharacterInfo characterInfo;

  Character(this.id, this.level, this.name, this.portrait, this.chRace,
      this.chClass, this.characteristics, this.characterInfo,this.description);
}
