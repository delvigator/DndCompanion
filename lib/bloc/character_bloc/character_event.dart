part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent {}

class SelectEvent extends CharacterEvent{
  Character character;

  SelectEvent(this.character);
}