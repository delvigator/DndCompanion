import 'package:dnd/bloc/information_bloc/information_bloc.dart';
import 'package:dnd/global_vars.dart';
import 'package:dnd/models/ch_race.dart';
import 'package:dnd/pages/character_selector/character_creation/feature_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../components/our_colors.dart';
import '../../character_list/character_edit_page.dart';
import 'creation_final.dart';

class CreationFeatures extends StatefulWidget {
  const CreationFeatures({super.key});
  static String routeName = "/creationFeatures";
  @override
  State<CreationFeatures> createState() => _CreationFeaturesState();
}

class _CreationFeaturesState extends State<CreationFeatures> {
  int currentNumber = 0;
  List<String> result=[];
  late List<bool> values = [];
  final int numberOfFeatures = 1;
  int maxNumber=0;

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    ChRace? currentRace = args["currentRace"];
    ChRace? currentSubRace = args["currentSubRace"];
    int mod=args["mod"];
    if(maxNumber==0 && mod!=1){maxNumber=((currentRace?.numberFeatures)!+(currentSubRace?.numberFeatures ?? 0));}
    return Scaffold(
      appBar: AppBar(
          title: const Text("Черты"),
          leading: const BackButton(
            color: Colors.white,
          )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            mod==0?
            selectedFeatures=List.from(result): selectedFeaturesEdit=List.from(result);
            result=[];
            Navigator.of(context).pop();},
          shape: const CircleBorder(),
          backgroundColor: OurColors.focusColorLight,
          foregroundColor: Colors.black,
          child: const Icon(Icons.check)),
      body: BlocBuilder<InformationBloc, InformationState>(
        bloc: informationBloc,
        builder: (context, state) {
          if (values.isEmpty) {
            values = mod==0 ? List.generate(
                informationBloc.state.features.length,
                    (index) =>
                    selectedFeatures.contains(informationBloc.state.features[index].name)
                    ? true
                    : false) : List.generate(
                informationBloc.state.features.length,
                    (index) =>
                selectedFeaturesEdit.contains(informationBloc.state.features[index].name)
                    ? true
                    : false);
            for (var element in values) {
              if (element == true) currentNumber++;
            }

            for (var element in mod==0 ? selectedFeatures : selectedFeaturesEdit) {
              if(!result.contains(element)) result.add(element);
            }
          }
          return Padding(
            padding: EdgeInsets.all(20.dp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Выберите черты, которыми владеет ваш персонаж",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
                SizedBox(
                  height: 4.h,
                ),
                mod== 0 ? Text(
                  "Можно выбрать: ${maxNumber-currentNumber}",
                  style: Theme
                      .of(context)
                      .textTheme.bodySmall
                      ?.copyWith(color: Colors.white),
                ) : Container(),
                SizedBox(
                  height: 4.h,
                ),
                Expanded(child: ListView(
                  children: informationBloc.state.features
                      .asMap()
                      .entries
                      .map((e) =>
                      Padding(padding: EdgeInsets.all(10.dp),
                        child: Container(
                          padding: EdgeInsets.all(3.dp),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CheckboxListTile(
                            checkboxShape: const CircleBorder(),
                            activeColor: OurColors.focusColor,
                            title: RichText(
                              text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushNamed(FeatureDescription.routeName,arguments: {"tappedFeature":e.value});
                                  },
                                text: e.value.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),

                            ),
                            value: values[e.key],
                            onChanged: (bool? value) {
                              if((currentNumber<maxNumber || mod==1) && value==true) {
                                setState(() {
                                  values[e.key] = value!;
                                  currentNumber++;
                                  result.add(e.value.name);
                                });
                              }
                              if(value==false){
                                values[e.key] = value!;
                                currentNumber--;
                                result.remove(e.value.name);
                              }
                            },
                          )
                        ),))
                      .toList(),
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
