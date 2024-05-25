import 'package:dnd/models/character.dart';
import 'package:dnd/models/characteristics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../components/our_colors.dart';
import '../../global_vars.dart';

class SkillBottomSheet extends StatelessWidget {
   SkillBottomSheet({super.key, required this.skill});

  final String skill;
  Character character=characterBloc.state.characters[characterBloc.state.currentCharacter];

  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        height: 70.h - 40.w,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar(title: "Навыки от характеристики"),
          body: SingleChildScrollView(
              child: SafeArea(
            child: Column(
              children: [
                Center(
                    child: Text(
                  skill,
                ),
                ),
                SizedBox(height: 3.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: character.characteristics.getChUnitByName(skill)!.skills.map((element) => Column(
                      children: [
                        Row(
                          children: [
                          Text(element.name),
                          SizedBox(width: 2.w,),
                          element.mastery ? const Icon(Icons.check) : Container()
                        ],),
                        SizedBox(height: 1.h,)
                      ],
                    )).toList(),
                  ),
                )
              ],
            ),
          )),
        ));
  }
}

AppBar appBar({
  String? title,
  bool showCloseIcon = true,
  Widget? leading,
}) {
  final BuildContext context = navKey.currentContext!;

  return AppBar(
    backgroundColor: Colors.transparent,
    leading: leading ?? Container(),
    leadingWidth: 4.dp,
    actions: showCloseIcon
        ? <Widget>[
            IconButton(
                icon: Icon(
                  Icons.close,
                  size: 21.dp,
                  color: OurColors.focusColorLight,
                ),
                onPressed: () => Navigator.of(context).pop())
          ]
        : null,
    centerTitle: true,
    title: (title == null)
        ? null
        : Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black)),
  );
}
