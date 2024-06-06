import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dnd/components/snack_bar.dart';
import 'package:dnd/http/requests.dart';
import 'package:dnd/models/ch_race.dart';
import 'package:dnd/models/feature.dart';
import 'package:dnd/models/magic_spell.dart';
import 'package:dnd/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../models/ch_class.dart';
import '../../models/item.dart';

part 'information_event.dart';
part 'information_state.dart';

class InformationBloc extends Bloc<InformationEvent, InformationState> {
  InformationBloc() : super( InformationState()) {
    on<LoadRacesEvent>(_onLoadRacesEvent);
    on<LoadClassesEvent>(_onLoadClassesEvent);
    on<LoadFeaturesEvent>(_onLoadFeaturesEvent);
    on<LoadSpellsEvent> (_onLoadSpellsEvent);
    on<LoadItemsEvent> (_onLoadItemsEvent);
    on<AddCustomItemsEvent>(_onAddCustomItemsEvent);

  }
  _onAddCustomItemsEvent(AddCustomItemsEvent event,Emitter<InformationState> emit) async {
    if(!state.items.contains(event.item)) {
      List<Item> result = List.from(state.customItems);
      result.add(event.item);
      debugPrint("saved${jsonEncode(result)}");
      emit(state.copyWith(customItems: result));
      saveInfo();
    }
    else {
      showSnackBar("Такой предмет уже есть");
    }
  }
  _onLoadItemsEvent(LoadItemsEvent event,Emitter<InformationState> emit) async {
    debugPrint("loaded");
    readInfo();
    if(state.items.isEmpty) {

      String data = await DefaultAssetBundle.of(event.context!).loadString(
          "assets/json/items.json");

      final result = jsonDecode(data);
      List<Item> items = List<Item>.generate(
          result.length, (index) => Item.fromJson(result[index]));
          emit(state.copyWith(items: items));
    }
    else {
      emit(state);
    }

  }
  _onLoadRacesEvent(LoadRacesEvent event,Emitter<InformationState> emit) async {
    List<ChRace> races=state.races;
   // String data = await DefaultAssetBundle.of(event.context!).loadString("assets/json/races.json");
   // final result = jsonDecode(data);
   await tryGetRaces(onSuccess: (headers,body){
     races= List<ChRace>.generate(body.length, (index) => ChRace.fromJson(body[index]));
   },
       onError: (code,body){
         showSnackBar("Не удалось загрузить расы");
       }).whenComplete(() =>   emit(state.copyWith(races: races)));


  }
  _onLoadClassesEvent(LoadClassesEvent event,Emitter<InformationState> emit)  async {
    List<ChClass> classes=state.classes;
    // String data = await DefaultAssetBundle.of(event.context!).loadString("assets/json/classes.json");
   await tryGetClasses(
        onSuccess: (headers,body){
        //  final result = jsonDecode(body);
           classes= List<ChClass>.generate(body.length, (index) => ChClass.fromJson(body[index]));
         // emit(state.copyWith(classes: classes));
    },
    onError: (code,body){
        showSnackBar("Не удалось загрузить классы");
    }
    ).whenComplete(() => emit(state.copyWith(classes: classes)) );


  }

  _onLoadFeaturesEvent(LoadFeaturesEvent event,Emitter<InformationState> emit) async {
    List<Feature> features=state.features;
    // String data = await DefaultAssetBundle.of(event.context!).loadString("assets/json/classes.json");
    await tryGetFeatures(
        onSuccess: (headers,body){
          //  final result = jsonDecode(body);
          features= List<Feature>.generate(body.length, (index) => Feature.fromJson(body[index]));
          // emit(state.copyWith(classes: classes));
        },
        onError: (code,body){
          showSnackBar("Не удалось загрузить черты");
        }
    ).whenComplete(() => emit(state.copyWith(features: features)) );


  }
  _onLoadSpellsEvent(LoadSpellsEvent event,Emitter<InformationState> emit) async {
    List<MagicSpell> spells=state.spells;
    // String data = await DefaultAssetBundle.of(event.context!).loadString("assets/json/classes.json");
    await tryGetSpells(
        onSuccess: (headers,body){
          //  final result = jsonDecode(body);
          spells= List<MagicSpell>.generate(body.length, (index) => MagicSpell.fromJson(body[index]));
          // emit(state.copyWith(classes: classes));
        },
        onError: (code,body){
          showSnackBar("Не удалось загрузить заклинания");
        }
    ).whenComplete(() => emit(state.copyWith(spells: spells)) );

  }
}
