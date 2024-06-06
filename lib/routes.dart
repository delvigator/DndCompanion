





import 'package:dnd/pages/auth/auth_main.dart';
import 'package:dnd/pages/auth/recovery_change.dart';
import 'package:dnd/pages/auth/recovery_mail.dart';
import 'package:dnd/pages/auth/recovery_pin.dart';
import 'package:dnd/pages/auth/register.dart';
import 'package:dnd/pages/auth/start.dart';
import 'package:dnd/pages/character_list/character_edit_page.dart';
import 'package:dnd/pages/character_list/level_up_page.dart';
import 'package:dnd/pages/character_selector/character_creation/creation_class.dart';
import 'package:dnd/pages/character_selector/character_creation/creation_features.dart';
import 'package:dnd/pages/character_selector/character_creation/creation_final.dart';
import 'package:dnd/pages/character_selector/character_creation/creation_race.dart';
import 'package:dnd/pages/character_selector/character_creation/feature_description.dart';
import 'package:dnd/pages/character_selector/character_creation/skills_selector.dart';
import 'package:dnd/pages/character_selector/selection_page.dart';
import 'package:dnd/pages/home/home_router.dart';
import 'package:dnd/pages/inventory/add_item_page.dart';
import 'package:dnd/pages/inventory/create_item.dart';
import 'package:dnd/pages/inventory/item_description.dart';
import 'package:dnd/pages/notes/add_note.dart';
import 'package:dnd/pages/notes/notes_page.dart';
import 'package:dnd/pages/spells_book/spell_description.dart';
import 'package:flutter/cupertino.dart';



final Map<String, WidgetBuilder> routes = {
SelectionPage.routeName: (context)=> const SelectionPage(),
  CreationRace.routeName: (context)=> const CreationRace(),
  CreationClass.routeName: (context,)=>const CreationClass(),
  CreationFinal.routeName: (context)=>const CreationFinal(),
  SkillsSelector.routeName:(context)=>const SkillsSelector(),
  CreationFeatures.routeName:(context)=>const CreationFeatures(),
  FeatureDescription.routeName:(context)=>const FeatureDescription(),
  SpellDescription.routeName:(context)=>const SpellDescription(),
  AddItem.routeName:(context)=>const AddItem(),
  ItemDescription.routeName:(context)=>const ItemDescription(),
  CreateItemPage.routeName:(context)=>const CreateItemPage(),
  AddNote.routeName:(context)=>const AddNote(),
  CharacterEditPage.routeName:(context)=>const CharacterEditPage(),
  NotesPage.routeName:(context)=>const NotesPage(),
  LevelUpPage.routeName:(context)=>const LevelUpPage(),
  AuthMain.routeName:(context)=>const AuthMain(),
  HomeRouter.routeName:(context)=>const HomeRouter(),
  RecoveryMail.routeName:(context)=>const RecoveryMail(),
  RecoveryChange.routeName:(context)=>const RecoveryChange(),
  RecoveryPin.routeName:(context)=>const RecoveryPin(),
  Start.routeName:(context)=>const Start(),
  Register.routeName:(context)=>const Register()
};