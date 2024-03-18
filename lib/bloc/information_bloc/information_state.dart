part of 'information_bloc.dart';

@immutable
class InformationState {
  final List<ChClass> classes;
 final List <ChRace> races;

  const InformationState({this.classes=const [], this.races=const []});
  InformationState copyWith({List<ChClass>? classes,List<ChRace>? races}){
    return InformationState(
      classes: classes ?? this.classes,
      races: races ?? this.races
    );
  }
}

