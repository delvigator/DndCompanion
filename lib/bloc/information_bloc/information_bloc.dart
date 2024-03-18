import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dnd/models/ch_race.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../models/ch_class.dart';

part 'information_event.dart';
part 'information_state.dart';

class InformationBloc extends Bloc<InformationEvent, InformationState> {
  InformationBloc() : super(const InformationState()) {
    on<LoadRacesEvent>(_onLoadRacesEvent);
  }
  _onLoadRacesEvent(LoadRacesEvent event,Emitter<InformationState> emit) async {
    String data = await DefaultAssetBundle.of(event.context!).loadString("assets/json/races.json");
    final result = jsonDecode(data);
    List<ChRace> races= List<ChRace>.generate(result.length, (index) => ChRace.fromJson(result[index]));
      emit(state.copyWith(races: races));

  }
}
