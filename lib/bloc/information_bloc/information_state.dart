part of 'information_bloc.dart';

@immutable
class InformationState {
  final List<ChClass> classes;
  final List<ChRace> races;
  final List<Feature> features;

  const InformationState(
      {this.classes = const [],
      this.features = const [],
      this.races = const []});

  InformationState copyWith(
      {List<ChClass>? classes, List<ChRace>? races, List<Feature>? features}) {
    return InformationState(
        classes: classes ?? this.classes,
        races: races ?? this.races,
        features: features ?? this.features);
  }
}
