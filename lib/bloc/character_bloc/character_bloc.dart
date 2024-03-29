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
  CharacterBloc() : super(const CharacterState()) {
    on<SelectEvent>(_onSelectEvent);
    on<LoadDataEvent>(_onLoadDataEvent);
    on<AddItemEvent>(_onAddItemEvent);
  }
_onSelectEvent(SelectEvent event,Emitter<CharacterState> emit){
emit(state.copyWith(currentCharacter:event.character));
}
_onLoadDataEvent(LoadDataEvent event,Emitter<CharacterState> emit) async {
  String data = await DefaultAssetBundle.of(event.context!).loadString("assets/json/characters.json");
  final result = jsonDecode(data);
  List<Character> characters= List<Character>.generate(result.length, (index) => Character.fromJson(result[index]));
  for (var element in state.characters) {
    if(!characters.contains(element)) characters.add(element);
  }
  if(characters!=state.characters) {
    emit(state.copyWith(characters: characters));
  }
}
_onAddItemEvent(AddItemEvent event,Emitter<CharacterState> emit){
    List<Character> result=List.from(state.characters);
    result.add(event.character);
    emit(state.copyWith(characters: result));
}
}
