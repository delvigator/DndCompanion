part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent {}

class SelectEvent extends CharacterEvent{
  final int indexCharacter;

  SelectEvent(this.indexCharacter);
}
class LoadDataEvent extends CharacterEvent{
  final BuildContext? context;

  LoadDataEvent(this.context);
}
class AddItemEvent extends CharacterEvent{
  final Character character;

  AddItemEvent(this.character);
}

class AddSelectedSpellEvent extends CharacterEvent {
  final MagicSpell magicSpell;

  AddSelectedSpellEvent(this.magicSpell);
}
class DeleteSelectedSpellEvent extends CharacterEvent {
  final MagicSpell magicSpell;

  DeleteSelectedSpellEvent(this.magicSpell);
}
class DeleteAllSelectedSpellsEvent extends CharacterEvent {

}
class AddKnownSpellEvent extends CharacterEvent {
  final MagicSpell magicSpell;

  AddKnownSpellEvent(this.magicSpell);
}
class DeleteKnownSpellEvent extends CharacterEvent {
  final MagicSpell magicSpell;

  DeleteKnownSpellEvent(this.magicSpell);
}
class ChangeCharactersEvent extends CharacterEvent{
  final List<Character> characters;

  ChangeCharactersEvent(this.characters);
}

class ChangeCharacterEvent extends CharacterEvent{
  final Character character;

  ChangeCharacterEvent(this.character);
}