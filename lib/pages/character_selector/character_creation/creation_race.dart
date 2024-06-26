import 'package:dnd/bloc/information_bloc/information_bloc.dart';
import 'package:dnd/components/default_button.dart';
import 'package:dnd/components/our_colors.dart';
import 'package:dnd/global_vars.dart';
import 'package:dnd/pages/character_selector/character_creation/creation_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../components/snack_bar.dart';
import '../../../models/ch_race.dart';

class CreationRace extends StatefulWidget {
  const CreationRace({super.key});

  static String routeName = "/creationRace";

  @override
  State<CreationRace> createState() => _CreationRaceState();
}

class _CreationRaceState extends State<CreationRace> {
  ChRace? currentRace;
  ChRace? currentSubRace;
@override
  void initState() {
  informationBloc.add(LoadRacesEvent(context));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 40) / 2;
    final double itemWidth = size.width / 2.5;
    return Scaffold(
        appBar: AppBar(
            title: const Text("Создание персонажа"),
            leading: const BackButton(
              color: Colors.white,
            )),
        body: BlocBuilder<InformationBloc, InformationState>(
          bloc: informationBloc,
          builder: (context, state) {
            List<ChRace> races=[];

              informationBloc.state.races.forEach((element) {
                if (!element.isSubRace) races.add(element);
              });
            
          //  informationBloc.add(LoadRacesEvent(context));
            return SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(20.dp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 10.w),
                      alignment: Alignment.topLeft,
                      child: Text("Выберите расу",
                          style: Theme.of(context).textTheme.titleMedium)),
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [
                          OurColors.lightPink,
                          Colors.white.withOpacity(0.05)
                        ],
                        stops: const [0.9, 1],
                        tileMode: TileMode.mirror,
                      ).createShader(bounds);
                    },
                    child: SizedBox(
                      width: 400.dp,
                      height: races.length > 4
                          ? 120.dp
                          : 60.dp,
                      child: GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: (itemWidth / itemHeight),
                          crossAxisCount:
                              races.length > 4 ? 2 : 1,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: races
                              .map((e) => DefaultButton(
                                    primaryColor: currentRace == e
                                        ? OurColors.lightPink
                                        : OurColors.focusColor,
                                    text: e.name,
                                    onPress: () {
                                      setState(() {
                                        currentRace = e;
                                        currentSubRace = null;
                                      });
                                    },
                                  ))
                              .toList()),
                    ),
                  ),
                  currentRace != null && currentRace!.subRace!.isNotEmpty
                      ? Container(
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          alignment: Alignment.topLeft,
                          child: Text("Выберите разновидность",
                              style: Theme.of(context).textTheme.titleMedium))
                      : Container(),
                  currentRace != null && currentRace!.subRace!.isNotEmpty
                      ? ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                OurColors.lightPink,
                                Colors.white.withOpacity(0.05)
                              ],
                              stops: const [0.9, 1],
                              tileMode: TileMode.mirror,
                            ).createShader(bounds);
                          },
                          child: SizedBox(
                            width: 300.dp,
                            height: 50.dp,
                            child: GridView.count(
                                shrinkWrap: true,
                                childAspectRatio: (itemWidth / itemHeight),
                                crossAxisCount: 1,
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children: currentRace!.subRace
                                    !.map((e) => DefaultButton(
                                          primaryColor: currentSubRace == e
                                              ? OurColors.lightPink
                                              : OurColors.focusColorTileLight,
                                          text: e.name,
                                          onPress: () {
                                            setState(() {
                                              currentSubRace = e;
                                            });
                                          },
                                        ))
                                    .toList()),
                          ),
                        )
                      : Container(),
                  currentRace != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding:
                                    EdgeInsets.only(top: 10.w, bottom: 5.w),
                                alignment: Alignment.topLeft,
                                child: Text("Информация",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium)),
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text("${currentRace?.description}",
                                    textAlign: TextAlign.justify,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Colors.white))),
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 4.w),
                                alignment: Alignment.topLeft,
                                child: Text("Особенности",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: currentRace!.peculiarities
                                  .map((perc) => RichText(
                                      textScaleFactor: 1,
                                      selectionColor: Colors.white,
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                          text: "${perc.title} ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                          children: [
                                            TextSpan(
                                                text: "${perc.text} \n",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.white)),
                                          ])))
                                  .toList(),
                            )
                          ],
                        )
                      : Container(),
                  currentSubRace != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 5.w),
                                alignment: Alignment.topLeft,
                                child: Text(currentSubRace!.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium)),
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text("${currentSubRace?.description}",
                                    textAlign: TextAlign.justify,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Colors.white))),
                            SizedBox(
                              height: 2.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: currentSubRace!.peculiarities
                                  .map((perc) => RichText(
                                      textScaleFactor: 1,
                                      selectionColor: Colors.white,
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                          text: "${perc.title} ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                          children: [
                                            TextSpan(
                                                text: "${perc.text} \n",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.white)),
                                          ])))
                                  .toList(),
                            )
                          ],
                        )
                      : Container(),
                   Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: currentRace==null ? 55.h : 0),
                            Container(
                                alignment: Alignment.bottomRight,
                                child: DefaultButton(
                                  primaryColor: OurColors.focusColorLight,
                                  text: "Далее",
                                  onPress: () {
                                    if( currentRace != null &&
                                        (currentSubRace != null ||
                                            currentRace!.subRace!.isEmpty)) {
                                      Navigator.of(context).pushNamed(
                                        CreationClass.routeName,
                                        arguments: {
                                          "currentRace": currentRace,
                                          "currentSubRace": currentSubRace,
                                          "mod":0
                                        });
                                    }
                                    else if( currentRace == null){
                                      showSnackBar("Выберите расу");
                                    }
                                    else if( currentSubRace == null &&
                                        currentRace!.subRace!.isNotEmpty){
                                      showSnackBar("Выберите разновидность");
                                    }
                                  },
                                )),
                          ],
                        )

                ],
              ),
            ));
          },
        ));
  }
}
