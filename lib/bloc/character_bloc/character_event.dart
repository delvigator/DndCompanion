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
class AddCharacterEvent extends CharacterEvent{
  final Character character;

  AddCharacterEvent(this.character);
}
class DeleteCurrentCharacterEvent extends CharacterEvent{

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

class AddItemEvent extends CharacterEvent {
  final ItemInInventory item;

  AddItemEvent(this.item);
}
class DeleteItemEvent extends CharacterEvent {
  final ItemInInventory item;

  DeleteItemEvent(this.item);
}

class EquipItemEvent extends CharacterEvent {
  final ItemInInventory item;

  EquipItemEvent(this.item);
}
class DisequipItemEvent extends CharacterEvent {
  final ItemInInventory item;

  DisequipItemEvent(this.item);
}

class AddNoteEvent extends CharacterEvent{
   final Note note;

   AddNoteEvent(this.note);
}

class DeleteNoteEvent extends CharacterEvent{
  final Note note;

  DeleteNoteEvent(this.note);
}

class SaveNoteEvent extends CharacterEvent{
  final Note noteOld;
  final Note noteNew;

  SaveNoteEvent(this.noteOld, this.noteNew);
}