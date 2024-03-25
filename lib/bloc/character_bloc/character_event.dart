part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent {}

class SelectEvent extends CharacterEvent{
  final Character character;

  SelectEvent(this.character);
}
class LoadDataEvent extends CharacterEvent{
  final BuildContext? context;

  LoadDataEvent(this.context);
}
class AddItemEvent extends CharacterEvent{
  final Character character;

  AddItemEvent(this.character);
}
