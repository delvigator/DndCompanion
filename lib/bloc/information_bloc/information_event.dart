part of 'information_bloc.dart';

@immutable
abstract class InformationEvent {}

class LoadRacesEvent extends InformationEvent {
  final BuildContext? context;

  LoadRacesEvent(this.context);
}
class LoadClassesEvent extends InformationEvent {
  final BuildContext? context;

  LoadClassesEvent(this.context);
}

class LoadFeaturesEvent extends InformationEvent {
  final BuildContext? context;

  LoadFeaturesEvent(this.context);
}
class LoadSpellsEvent extends InformationEvent {
  final BuildContext? context;

  LoadSpellsEvent(this.context);
}
class LoadItemsEvent extends InformationEvent {
  final BuildContext? context;

  LoadItemsEvent(this.context);
}

class AddCustomItemsEvent extends InformationEvent {
  final Item item;
  AddCustomItemsEvent(this.item);
}