import 'package:dnd/bloc/information_bloc/information_bloc.dart';
import 'package:dnd/components/skills.dart';
import 'package:dnd/models/ch_class.dart';
import 'package:dnd/models/ch_race.dart';
import 'package:dnd/models/character.dart';
import 'package:dnd/models/character_info.dart';
import 'package:flutter/cupertino.dart';


import 'bloc/character_bloc/character_bloc.dart';
import 'models/characteristics.dart';
import 'models/user_data.dart';


CharacterBloc characterBloc = CharacterBloc();
InformationBloc informationBloc = InformationBloc();
final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
 Map<String,List<TextEditingController>> globalSpells={};
List<bool> globalChecks=[];