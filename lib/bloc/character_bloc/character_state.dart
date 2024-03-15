part of 'character_bloc.dart';

@immutable
 class CharacterState {
  final Character? currentCharacter;

  const CharacterState({this.currentCharacter});

  CharacterState copyWith( {
   Character? currentCharacter
}){
    return CharacterState(
    currentCharacter: currentCharacter ?? this.currentCharacter
    );
}


}


