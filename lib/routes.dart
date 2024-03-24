


import 'package:dnd/pages/character_selector/character_creation/creation_class.dart';
import 'package:dnd/pages/character_selector/character_creation/creation_final.dart';
import 'package:dnd/pages/character_selector/character_creation/creation_race.dart';
import 'package:dnd/pages/character_selector/character_creation/skills_selector.dart';
import 'package:dnd/pages/character_selector/selection_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, WidgetBuilder> routes = {
SelectionPage.routeName: (context)=> const SelectionPage(),
  CreationRace.routeName: (context)=> const CreationRace(),
  CreationClass.routeName: (context,)=>const CreationClass(),
  CreationFinal.routeName: (context)=>const CreationFinal(),
  SkillsSelector.routeName:(context)=>const SkillsSelector()
};