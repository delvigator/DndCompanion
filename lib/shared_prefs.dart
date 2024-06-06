import 'dart:convert';

import 'package:dnd/bloc/character_bloc/character_bloc.dart';
import 'package:dnd/global_vars.dart';
import 'package:dnd/models/ch_class.dart';
import 'package:dnd/models/ch_race.dart';
import 'package:dnd/models/feature.dart';
import 'package:dnd/models/magic_spell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/character.dart';
import 'models/item.dart';
Future<void> readUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userData.login64=prefs.getString("username") ?? "";
  userData.password64=prefs.getString("password") ?? "";
}
Future<void> readInfo() async {
  debugPrint("Reading information....");
  SharedPreferences prefs = await SharedPreferences.getInstance();
 var data = jsonDecode(prefs.getString("classes")!);
  if(data!=null) {
    informationBloc.state.classes = List<ChClass>.generate(
        data.length, (index) => ChClass.fromJson(data[index]));
  }
  data = jsonDecode(prefs.getString("customItems")!);
  if(data!=null) {
    informationBloc.state.customItems = List<Item>.generate(
        data.length, (index) => Item.fromJson(data[index]));
  }
  data = jsonDecode(prefs.getString("items")!);
  if(data!=null) {
    informationBloc.state.items = List<Item>.generate(
        data.length, (index) => Item.fromJson(data[index]));
  }
  data = jsonDecode(prefs.getString("races")!);
  if(data!=null) {
    informationBloc.state.races = List<ChRace>.generate(
        data.length, (index) => ChRace.fromJson(data[index]));
  }
  data = jsonDecode(prefs.getString("spells")!);
  if(data!=null) {
    informationBloc.state.spells = List<MagicSpell>.generate(
        data.length, (index) => MagicSpell.fromJson(data[index]));
  }
  data = jsonDecode(prefs.getString("features")!);
  if(data!=null){
    informationBloc.state.features = List<Feature>.generate(
        data.length, (index) => Feature.fromJson(data[index]));
  }
}
Future<void> readPrefs(BuildContext context) async {
  debugPrint("Read character information....");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var data = jsonDecode(prefs.getString("characters")!);
  debugPrint(prefs.getString("characters")!);
  List<Character> result=[];
  result = List<Character>.generate(
      data.length, (index) => Character.fromJson(data[index]));
characterBloc.add(ChangeCharactersEvent(result));
  data = jsonDecode(prefs.getString("currentCharacter")!);
  if(data!=null) {
    characterBloc.add(SelectEvent(data));
  }

  data = jsonDecode(prefs.getString("currentSpells")!);
  characterBloc.state.currentSpells = List<MagicSpell>.generate(
      data.length, (index) => MagicSpell.fromJson(data[index]));

  data=jsonDecode(prefs.getString("globalSpells")!);
  Map<String,List<TextEditingController>> controllersMap={};
  List<dynamic> list=[];
  data.forEach((key, value) {
    list=value;
    List<TextEditingController>controllersList=[];
    for (var element in list) {
      TextEditingController controller=TextEditingController();
      controller.text=element;
      controllersList.add(controller);
    }
    controllersMap.putIfAbsent(key, () => controllersList);

  });
    globalSpells=controllersMap;

}

void saveCharacterInfo() {
debugPrint("Saving character information....");

  List<String> resultList = [];
  Map<String,List<String>> spells={};
  globalSpells.forEach((key, value) {
    resultList = [];
    for (var element in value) {
      resultList.add(element.text);

    }
    spells.putIfAbsent(key, () => resultList);
  });
  final Map<String, dynamic> map = {
    "characters": jsonEncode(characterBloc.state.characters),
    "currentCharacter": jsonEncode(characterBloc.state.currentCharacter),
    "currentSpells": jsonEncode(characterBloc.state.currentSpells),
    "globalSpells": jsonEncode(spells)
  };
  savePrefs(map);
}
void saveUserData() {
  final Map<String, dynamic> map = {
    "username": userData.login64,
    "password": userData.password64,
  };
  savePrefs(map);
}

void saveInfo() {
  final Map<String, dynamic> map = {
    "classes": jsonEncode(informationBloc.state.classes),
    "races": jsonEncode(informationBloc.state.races),
    "spells": jsonEncode(informationBloc.state.spells),
    "features": jsonEncode(informationBloc.state.features),
    "customItems":jsonEncode(informationBloc.state.customItems),
    "items":jsonEncode(informationBloc.state.items)
  };
  savePrefs(map);
}

Future<void> savePrefs(Map<String, dynamic> pairs) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  pairs.forEach((key, value) {
    if (value is String) {
      prefs.setString(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    }
  });
}
