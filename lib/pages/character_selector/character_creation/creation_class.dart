import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../bloc/information_bloc/information_bloc.dart';
import '../../../components/default_button.dart';
import '../../../components/our_colors.dart';
import '../../../global_vars.dart';
import '../../../models/ch_class.dart';

class CreationClass extends StatefulWidget {
  const CreationClass({super.key});

  static String routeName = "/creationClass";

  @override
  State<CreationClass> createState() => _CreationClassState();
}

class _CreationClassState extends State<CreationClass> {
  ChClass? currentClass;
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
            informationBloc.add(LoadClassesEvent(context));
            return SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(20.dp),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 10.w),
                      alignment: Alignment.topLeft,
                      child: Text("Выберите класс",
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
                      height: informationBloc.state.classes.length>4 ? 120.dp : 60.dp,
                      child: GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: (itemWidth / itemHeight),
                          crossAxisCount: informationBloc.state.classes.length>4 ? 2 :1,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: informationBloc.state.classes
                              .map((e) => DefaultButton(
                                    primaryColor: currentClass == e
                                        ? OurColors.lightPink
                                        : OurColors.focusColor,
                                    text: e.name,
                                    onPress: () {
                                      debugPrint(currentClass?.name);
                                      debugPrint(e.name);
                                      setState(() {
                                        currentClass = e;
                                      });
                                    },
                                  ))
                              .toList()),
                    ),
                  ),

                  currentClass != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: 10.w,bottom: 5.w),
                                alignment: Alignment.topLeft,
                                child: Text("Информация",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium)),
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text("${currentClass?.classInfo.description}",
                                    textAlign: TextAlign.justify,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Colors.white))),
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 4.w),
                                alignment: Alignment.topLeft,
                                child: Text("Умения",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: currentClass!.classSkillsText
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

                  currentClass != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                padding: EdgeInsets.all(5.w),
                                width: 50.w,
                                alignment: Alignment.bottomRight,
                                child: const DefaultButton(text: "Далее")),
                          ],
                        )
                      : Container()
                ],
              ),
            ));
          },
        ));
  }
}
