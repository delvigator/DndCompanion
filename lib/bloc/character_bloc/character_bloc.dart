import 'dart:convert';

import 'package:dnd/components/snack_bar.dart';
import 'package:dnd/http/requests.dart';
import 'package:dnd/models/character.dart';
import 'package:dnd/models/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/magic_spell.dart';
import '../../models/note.dart';
import '../../pages/character_list/character_edit_page.dart';
import '../../shared_prefs.dart';

part 'character_event.dart';

part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(CharacterState()) {
    on<SelectEvent>(_onSelectEvent);
    on<LoadDataEvent>(_onLoadDataEvent);
    on<AddCharacterEvent>(_onAddCharacterEvent);
    on<AddSelectedSpellEvent>(_onAddSelectedSpellEvent);
    on<DeleteSelectedSpellEvent>(_onDeleteSelectedSpellEvent);
    on<DeleteAllSelectedSpellsEvent>(_onDeleteAllSelectedSpellsEvent);
    on<AddKnownSpellEvent>(_onAddKnownSpellEvent);
    on<DeleteKnownSpellEvent>(_onDeleteKnownSpellEvent);
    on<AddItemEvent>(_onAddItemEvent);
    on<DeleteItemEvent>(_onDeleteItemEvent);
    on<ChangeCharactersEvent>(_onChangeCharacters);
    on<ChangeCharacterEvent>(_onChangeCharacter);
    on<EquipItemEvent>(_onEquipItemEvent);
    on<DisequipItemEvent>(_onDisequipItemEvent);
    on<AddNoteEvent>(_onAddNoteEvent);
    on<DeleteNoteEvent>(_onDeleteNoteEvent);
    on<SaveNoteEvent>(_onSaveNoteEvent);
    on<DeleteCurrentCharacterEvent>(_onDeleteCurrentCharacterEvent);
  }

  _onSaveNoteEvent(SaveNoteEvent event, Emitter<CharacterState> emit) {
    List<Note> result =
        List.from(state.characters[state.currentCharacter].notes);
    result[result.indexOf(event.noteOld)] = event.noteNew;
    Character character =
        state.characters[state.currentCharacter].copyWith(notes: result);

    List<Character> characters = List.from(state.characters);
    characters[characters.indexOf(character)] = character;
    emit(state.copyWith(characters: characters));
   // saveCharacter(character);
    saveCharacterInfo();
  }
saveCharacter(Character character){

  tryChangeCharacter(onSuccess: (headers,body){
  },
  onError: (headers,body){
    showSnackBar("Не удалось сохранить персонажа");
  }, character: character);
}
  _onDeleteNoteEvent(DeleteNoteEvent event, Emitter<CharacterState> emit) {
    List<Note> result =
        List.from(state.characters[state.currentCharacter].notes);
    result.remove(event.note);
    Character character =
        state.characters[state.currentCharacter].copyWith(notes: result);
    List<Character> characters = List.from(state.characters);
    characters[characters.indexOf(character)] = character;
    emit(state.copyWith(characters: characters));
    saveCharacterInfo();
    //saveCharacter(character);
  }

  _onAddNoteEvent(AddNoteEvent event, Emitter<CharacterState> emit) {
    List<Note> result =
        List.from(state.characters[state.currentCharacter].notes);
    result.add(event.note);
    Character character =
        state.characters[state.currentCharacter].copyWith(notes: result);
    List<Character> characters = List.from(state.characters);
    characters[characters.indexOf(character)] = character;
    emit(state.copyWith(characters: characters));
    saveCharacterInfo();
   // saveCharacter(character);
  }

  _onSelectEvent(SelectEvent event, Emitter<CharacterState> emit) {
    if(state.currentCharacter!=-1) saveCharacter(state.characters[state.currentCharacter]);
    emit(state.copyWith(currentCharacter: event.indexCharacter));
    simpleSkillsSelectedEdit = [];
    selectedFeaturesEdit = [];
    saveCharacterInfo();
    tryChangeSelectedCharacter(onSuccess: (headers,body){}, index: event.indexCharacter);

  }

  _onChangeCharacters(
      ChangeCharactersEvent event, Emitter<CharacterState> emit) {
    emit(state.copyWith(characters: event.characters));
    saveCharacterInfo();
  }
  _onDeleteCurrentCharacterEvent(DeleteCurrentCharacterEvent event, Emitter<CharacterState> emit) {
    tryDeleteCharacter(onSuccess: (headers,body){
      tryChangeSelectedCharacter(onSuccess: (headers,body){
        state.characters.remove(state.characters[state.currentCharacter]);
        state.currentCharacter=-1;
        emit(state);
        saveCharacterInfo();
      },
      onError: (headers,body){
        showSnackBar("Не удалось удалить персонажа");
      }, index: -1);
    }, id: state.characters[state.currentCharacter].id);


  }
  _onChangeCharacter(ChangeCharacterEvent event, Emitter<CharacterState> emit) {
    if (state.currentCharacter != -1) {
      debugPrint("onChangeCharacterEvent");
      List<Character> list = List.from(state.characters);
      list[state.currentCharacter] = event.character;
      state.characters[state.currentCharacter] = event.character;
      emit(state.copyWith(characters: list));
      saveCharacterInfo();
      //saveCharacter(event.character);
    }
    //debugPrint(state.characters[state.currentCharacter].characterInfo.toJson().toString());

  }

  _onLoadDataEvent(LoadDataEvent event, Emitter<CharacterState> emit) async {
    String data = await DefaultAssetBundle.of(event.context!)
        .loadString("assets/json/characters.json");
    final result = jsonDecode(data);
    List<Character> characters = List<Character>.generate(
        result.length, (index) => Character.fromJson(result[index]));
    for (var element in state.characters) {
      if (!characters.contains(element)) characters.add(element);
    }
    if (characters != state.characters) {
      emit(state.copyWith(characters: characters));
    }
  }

  _onAddCharacterEvent(AddCharacterEvent event, Emitter<CharacterState> emit) {
    List<Character> result = List.from(state.characters);
    debugPrint(jsonEncode(event.character));
    result.add(event.character);
    emit(state.copyWith(characters: result));
    tryCreateCharacter(onSuccess: (headers,body){},
        onError: (headers,body){
      debugPrint(body);
        }, character: event.character);
    saveCharacterInfo();
  }

  _onAddSelectedSpellEvent(
      AddSelectedSpellEvent event, Emitter<CharacterState> emit) {
    List<MagicSpell> result = List.from(state.currentSpells);
    if (!result.contains(event.magicSpell)) {
      result.add(event.magicSpell);
    }
    if(result!=state.currentSpells) {
      emit(state.copyWith(currentSpells: result));

      saveCharacterInfo();
    }
  }

  _onDeleteSelectedSpellEvent(
      DeleteSelectedSpellEvent event, Emitter<CharacterState> emit) {
    List<MagicSpell> result = List.from(state.currentSpells);
    result.remove(event.magicSpell);
    emit(state.copyWith(currentSpells: result));
    saveCharacterInfo();
  }

  _onDeleteAllSelectedSpellsEvent(
      DeleteAllSelectedSpellsEvent event, Emitter<CharacterState> emit) {
    emit(state.copyWith(currentSpells: []));
    saveCharacterInfo();
  }

  _onAddKnownSpellEvent(
      AddKnownSpellEvent event, Emitter<CharacterState> emit) {
    if (state.currentCharacter != -1) {
      List<MagicSpell> result =
          List.from(state.characters[state.currentCharacter].knownSpells);
      Character? character = state.characters[state.currentCharacter];
      if (!result.contains(event.magicSpell)) {
        result.add(event.magicSpell);
        state.characters[state.currentCharacter].copyWith(knownSpells: result);
        // state.characters[state.currentCharacter].knownSpells
        //     .add(event.magicSpell);
        emit(state.copyWith());
      }
     // saveCharacter(state.characters[state.currentCharacter]);
      saveCharacterInfo();
    }
  }

  _onDeleteKnownSpellEvent(
      DeleteKnownSpellEvent event, Emitter<CharacterState> emit) {
    if (state.currentCharacter != -1) {
      state.characters[state.currentCharacter].knownSpells
          .remove(event.magicSpell);
     // saveCharacter(state.characters[state.currentCharacter]);
      saveCharacterInfo();
    }
  }

  _onAddItemEvent(AddItemEvent event, Emitter<CharacterState> emit) {
    if (state.currentCharacter != -1) {
      List<ItemInInventory> result =
          List.from(state.characters[state.currentCharacter].items);
      Character? character = state.characters[state.currentCharacter];

      if (!result.contains(event.item)) {
        result.add(event.item);
        character = character.copyWith(items: result);
        List<Character> characters = List.from(state.characters);
        characters[state.currentCharacter] = character;
        emit(state.copyWith(characters: characters));
        // state.characters[state.currentCharacter].items.add(event.item);
      }
      //saveCharacter(state.characters[state.currentCharacter]);
      saveCharacterInfo();
    }
  }

  _onDeleteItemEvent(DeleteItemEvent event, Emitter<CharacterState> emit) {
    if (state.currentCharacter != -1) {
      state.characters[state.currentCharacter].items.remove(event.item);
   //   saveCharacter(state.characters[state.currentCharacter]);
      saveCharacterInfo();
    }
  }

  _onEquipItemEvent(EquipItemEvent event, Emitter<CharacterState> emit) {
    if (state.currentCharacter != -1) {
      int index =
          state.characters[state.currentCharacter].items.indexOf(event.item);
      state.characters[state.currentCharacter].items[index].equip = true;
      saveCharacterInfo();
      //saveCharacter(state.characters[state.currentCharacter]);
      emit(state);
    }
  }

  _onDisequipItemEvent(DisequipItemEvent event, Emitter<CharacterState> emit) {
    if (state.currentCharacter != -1) {
      List<ItemInInventory> result =
          List.from(state.characters[state.currentCharacter].items);
      Character? character = state.characters[state.currentCharacter];
      int index =
          state.characters[state.currentCharacter].items.indexOf(event.item);
      character.items[index].equip = false;
      character = character.copyWith(items: result);
      List<Character> characters = List.from(state.characters);
      characters[state.currentCharacter] = character;
      emit(state.copyWith(characters: characters));
      // state.characters[state.currentCharacter].items.add(event.item);
      saveCharacterInfo();
      //saveCharacter(state.characters[state.currentCharacter]);
    }
  }
}
