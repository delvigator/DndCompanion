import 'dart:async';
import 'dart:convert';

import 'package:dnd/models/character.dart';
import 'package:dnd/models/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global_vars.dart';



part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(CharacterState()) {
    on<SelectEvent>(_onSelectEvent);
    on<LoadDataEvent>(_onLoadDataEvent);
  }
_onSelectEvent(SelectEvent event,Emitter<CharacterState> emit){
emit(state.copyWith(currentCharacter:event.character));
}
_onLoadDataEvent(LoadDataEvent event,Emitter<CharacterState> emit) async {
  String data = await DefaultAssetBundle.of(event.context!).loadString("assets/json/characters.json");
  final result = jsonDecode(data);
  List<Character> characters= List<Character>.generate(result.length, (index) => Character.fromJson(result[index]));
  if(characters!=state.characters) {
    emit(state.copyWith(characters: characters));
  }
}
}
