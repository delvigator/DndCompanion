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

