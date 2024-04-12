import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dnd/models/ch_race.dart';
import 'package:dnd/models/feature.dart';
import 'package:dnd/models/magic_spell.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../models/ch_class.dart';

part 'information_event.dart';
part 'information_state.dart';

class InformationBloc extends Bloc<InformationEvent, InformationState> {
  InformationBloc() : super( InformationState()) {
    on<LoadRacesEvent>(_onLoadRacesEvent);
    on<LoadClassesEvent>(_onLoadClassesEvent);
    on<LoadFeaturesEvent>(_onLoadFeaturesEvent);
    on<LoadSpellsEvent> (_onLoadSpellsEvent);
  }
  _onLoadRacesEvent(LoadRacesEvent event,Emitter<InformationState> emit) async {
    String data = await DefaultAssetBundle.of(event.context!).loadString("assets/json/races.json");
    final result = jsonDecode(data);
    List<ChRace> races= List<ChRace>.generate(result.length, (index) => ChRace.fromJson(result[index]));
      emit(state.copyWith(races: races));

  }
  _onLoadClassesEvent(LoadClassesEvent event,Emitter<InformationState> emit) async {
    String data = await DefaultAssetBundle.of(event.context!).loadString("assets/json/classes.json");
    final result = jsonDecode(data);
    List<ChClass> classes= List<ChClass>.generate(result.length, (index) => ChClass.fromJson(result[index]));
    emit(state.copyWith(classes: classes));

  }

  _onLoadFeaturesEvent(LoadFeaturesEvent event,Emitter<InformationState> emit) async {
    String data = await DefaultAssetBundle.of(event.context!).loadString("assets/json/features.json");
    final result = jsonDecode(data);
    List<Feature> features= List<Feature>.generate(result.length, (index) => Feature.fromJson(result[index]));
    emit(state.copyWith(features: features));

  }
  _onLoadSpellsEvent(LoadSpellsEvent event,Emitter<InformationState> emit) async {
    String data = await DefaultAssetBundle.of(event.context!).loadString("assets/json/spells.json");
    final result = jsonDecode(data);
    List<MagicSpell> spells= List<MagicSpell>.generate(result.length, (index) => MagicSpell.fromJson(result[index]));
    emit(state.copyWith(spells: spells));

  }
}
