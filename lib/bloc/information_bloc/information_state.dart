part of 'information_bloc.dart';

@immutable
class InformationState {
   List<ChClass> classes;
   List<ChRace> races;
   List<Feature> features;
   List<MagicSpell> spells;

   InformationState(
      {this.classes = const [],
        this.spells=const [],
      this.features = const [],
      this.races = const []});

  InformationState copyWith(
      {List<ChClass>? classes, List<ChRace>? races, List<Feature>? features, List<MagicSpell>? spells}) {
    return InformationState(
        classes: classes ?? this.classes,
        races: races ?? this.races,
        features: features ?? this.features,
      spells: spells ?? this.spells
    );
  }
}
