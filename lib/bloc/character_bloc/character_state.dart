part of 'character_bloc.dart';

@immutable
class CharacterState {
   int currentCharacter;
   List<Character> characters;
   List<MagicSpell> currentSpells; //заклинания выыбранные при филтрации в книге

   CharacterState({this.currentCharacter=-1, this.characters=const [],this.currentSpells=const []});

  CharacterState copyWith({int? currentCharacter, List<Character>?characters, List<MagicSpell>? currentSpells }) {
    return CharacterState(
        currentCharacter: currentCharacter ?? this.currentCharacter,
        characters: characters ?? this.characters,
    currentSpells: currentSpells ?? this.currentSpells
    );
  }
}
