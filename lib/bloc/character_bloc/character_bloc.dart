import 'dart:async';
import 'dart:convert';

import 'package:dnd/models/character.dart';
import 'package:dnd/models/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global_vars.dart';
import '../../models/magic_spell.dart';
import '../../shared_prefs.dart';



part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super( CharacterState()) {
    on<SelectEvent>(_onSelectEvent);
    on<LoadDataEvent>(_onLoadDataEvent);
    on<AddItemEvent>(_onAddItemEvent);
    on<AddSelectedSpellEvent>(_onAddSelectedSpellEvent);
    on<DeleteSelectedSpellEvent>(_onDeleteSelectedSpellEvent);
    on<DeleteAllSelectedSpellsEvent>(_onDeleteAllSelectedSpellsEvent);
    on<AddKnownSpellEvent>(_onAddKnownSpellEvent);
    on<DeleteKnownSpellEvent>(_onDeleteKnownSpellEvent);
    on<ChangeCharactersEvent>(_onChangeCharacters);
    on<ChangeCharacterEvent>(_onChangeCharacter);
  }
_onSelectEvent(SelectEvent event,Emitter<CharacterState> emit){
emit(state.copyWith(currentCharacter:event.indexCharacter));
saveCharacterInfo();
}
_onChangeCharacters(ChangeCharactersEvent event, Emitter<CharacterState> emit){
    emit(state.copyWith(characters: event.characters));
}
  _onChangeCharacter(ChangeCharacterEvent event, Emitter<CharacterState> emit){

    if(state.currentCharacter!=-1) {
      List<Character> list=List.from(state.characters);
      list[state.currentCharacter]=event.character;
      state.characters[state.currentCharacter]=event.character;
      emit(state.copyWith(characters: list));

    }
    debugPrint(state.characters[state.currentCharacter].characterInfo.toJson().toString());
    saveCharacterInfo();
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
    saveCharacterInfo();
}
_onAddSelectedSpellEvent( AddSelectedSpellEvent event,Emitter<CharacterState> emit){
    List<MagicSpell> result=List.from(state.currentSpells);
    if(!result.contains(event.magicSpell)) {
      result.add(event.magicSpell);
    }
    emit(state.copyWith(currentSpells: result));
    saveCharacterInfo();
}
  _onDeleteSelectedSpellEvent( DeleteSelectedSpellEvent event,Emitter<CharacterState> emit){
    List<MagicSpell> result=List.from(state.currentSpells);
    result.remove(event.magicSpell);
    emit(state.copyWith(currentSpells: result));
    saveCharacterInfo();
  }
  _onDeleteAllSelectedSpellsEvent( DeleteAllSelectedSpellsEvent event,Emitter<CharacterState> emit){
    emit(state.copyWith(currentSpells: []));
    saveCharacterInfo();
  }

  _onAddKnownSpellEvent( AddKnownSpellEvent event,Emitter<CharacterState> emit){
    if(state.currentCharacter!=-1) {
      List<MagicSpell> result = List.from(
          state.characters[state.currentCharacter].knownSpells);
      Character? character = state.characters[state.currentCharacter];
      if (!result.contains(event.magicSpell)) {
        state.characters[state.currentCharacter].knownSpells.add(event.magicSpell);
      }
      saveCharacterInfo();
    }
  }

  _onDeleteKnownSpellEvent( DeleteKnownSpellEvent event,Emitter<CharacterState> emit){
    if(state.currentCharacter!=-1) {
      state.characters[state.currentCharacter].knownSpells.remove(
          event.magicSpell);
      saveCharacterInfo();
    }
  }

}

