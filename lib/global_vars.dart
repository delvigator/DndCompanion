import 'package:dnd/bloc/information_bloc/information_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'bloc/character_bloc/character_bloc.dart';
import 'models/user.dart';

CharacterBloc characterBloc = CharacterBloc();
InformationBloc informationBloc = InformationBloc();
final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
final scaffoldKey = GlobalKey<ScaffoldState>();
 Map<String,List<TextEditingController>> globalSpells={};
List<bool> globalChecks=[];
 User userData=User(characters: [], currentCharacter: -1, customItems: []);