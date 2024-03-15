part of 'character_bloc.dart';

@immutable
class CharacterState {
  final Character? currentCharacter;
  final List<Character>? characters;

  const CharacterState({this.currentCharacter, this.characters=const []});

  CharacterState copyWith({Character? currentCharacter, List<Character>?characters }) {
    return CharacterState(
        currentCharacter: currentCharacter ?? this.currentCharacter,
        characters: characters ?? this.characters);
  }
}
