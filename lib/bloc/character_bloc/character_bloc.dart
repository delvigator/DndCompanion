import 'dart:async';

import 'package:dnd/models/character.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(const CharacterState()) {
    on<SelectEvent>(_onSelectEvent);
  }
_onSelectEvent(SelectEvent event,Emitter<CharacterState> emit){
emit(state.copyWith(currentCharacter:event.character));
}
}
