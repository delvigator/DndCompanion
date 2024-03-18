import 'package:dnd/bloc/information_bloc/information_bloc.dart';
import 'package:dnd/components/default_button.dart';
import 'package:dnd/components/our_colors.dart';
import 'package:dnd/global_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

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
            informationBloc.add(LoadRacesEvent(context));
            return SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(20.dp),
              child: Column(
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
                        stops: [0.9, 1],
                        tileMode: TileMode.mirror,
                      ).createShader(bounds);
                    },
                    child: SizedBox(
                      width: 400.dp,
                      height: 120.dp,
                      child: GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: (itemWidth / itemHeight),
                          crossAxisCount: 2,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: informationBloc.state.races
                              .map((e) => DefaultButton(
                                    primaryColor: currentRace == e
                                        ? OurColors.lightPink
                                        : OurColors.focusColor,
                                    text: e.name,
                                    onPress: () {
                                      debugPrint(currentRace?.name);
                                      debugPrint(e.name);
                                      setState(() {
                                        currentRace = e;
                                        currentSubRace = null;
                                      });
                                    },
                                  ))
                              .toList()),
                    ),
                  ),
                  currentRace != null && currentRace!.subRace.isNotEmpty
                      ? Container(
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          alignment: Alignment.topLeft,
                          child: Text("Выберите разновидность",
                              style: Theme.of(context).textTheme.titleMedium))
                      : Container(),
                  currentRace != null && currentRace!.subRace.isNotEmpty
                      ? ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                OurColors.lightPink,
                                Colors.white.withOpacity(0.05)
                              ],
                              stops: [0.9, 1],
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
                                    .map((e) => DefaultButton(
                                          primaryColor: currentSubRace == e
                                              ? OurColors.lightPink
                                              : OurColors.focusColorLight,
                                          text: e.name,
                                          onPress: () {
                                            debugPrint(currentRace?.name);
                                            debugPrint(e.name);
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
                                padding: EdgeInsets.symmetric(vertical: 10.w),
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
                                      text:
                                      TextSpan(
                                        text: "${perc.title} ",
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),
                                          children: [
                                        TextSpan(
                                            text: "${perc.text} \n",
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),

                                      ])))
                                  .toList(),
                            )
                          ],
                        )
                      : Container(),
                  currentSubRace !=null ?
                  Column(
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
                      SizedBox(height: 2.h,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: currentSubRace!.peculiarities
                            .map((perc) => RichText(
                            textScaleFactor: 1,
                            selectionColor: Colors.white,
                            textAlign: TextAlign.start,
                            text:
                            TextSpan(
                                text: "${perc.title} ",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: "${perc.text} \n",
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),

                                ])))
                            .toList(),
                      )
                    ],
                  )
                      : Container(),
                      currentRace!=null && (currentSubRace!=null || currentRace!.subRace.isEmpty) ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.w),
                          width: 50.w,
                        alignment: Alignment.bottomRight,
                          child: const DefaultButton(text: "Далее")),
                    ],
                  ) : Container()
                ],
              ),
            ));
          },
        ));
  }
}
