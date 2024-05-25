part of 'character_bloc.dart';

@immutable
class CharacterState {
   int currentCharacter;
   List<Character> characters;
   //заклинания выыбранные при филтрации в книге
   List<MagicSpell> currentSpells;

   Character? getByName(String name){
     debugPrint(name);
     Character? result;
     for (var element in characters) {
       if(element.name==name) result=element;
     }
     debugPrint(result.toString());
         return result;
  }
   CharacterState({this.currentCharacter=-1, this.characters=const [],this.currentSpells=const []});

  CharacterState copyWith({int? currentCharacter, List<Character>?characters, List<MagicSpell>? currentSpells }) {
    return CharacterState(
        currentCharacter: currentCharacter ?? this.currentCharacter,
        characters: characters ?? this.characters,
    currentSpells: currentSpells ?? this.currentSpells
    );
  }
}
