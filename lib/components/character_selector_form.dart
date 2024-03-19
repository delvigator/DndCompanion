import 'package:dnd/bloc/character_bloc/character_bloc.dart';
import 'package:dnd/components/our_colors.dart';
import 'package:dnd/components/wigets.dart';
import 'package:dnd/global_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../models/character.dart';

class CharacterSelectorForm extends StatefulWidget {
  final Character character;

  const CharacterSelectorForm({
    super.key,
    required this.character,
    //required this.character
  });

  @override
  State<CharacterSelectorForm> createState() => _CharacterSelectorFormState();
}

class _CharacterSelectorFormState extends State<CharacterSelectorForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: characterBloc,
      builder: (context, state) {
        return Card(
          color: characterBloc.state.currentCharacter == widget.character ? OurColors.lightPink : OurColors.focusColor,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ExpansionTile(
            //   trailing: Icon(Icons.keyboard_arrow_down, color: Colors.black,),
          //  backgroundColor: characterBloc.state.currentCharacter == widget.character ? OurColors.lightPink : OurColors.focusColor,
            // collapsedBackgroundColor: Colors.white,
            iconColor: Colors.black,
            collapsedIconColor: Colors.black,
            title: Text(
                widget.character.name, style: Theme.of(context).textTheme.bodyMedium),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.character.level} уровень",
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                characterBloc.state.currentCharacter == widget.character ?
                const Text("Текущий",style: TextStyle(color: OurColors.focusColorLight),) : Container()
              ],
            ),
            children: [
              Container(
                padding: EdgeInsets.all(12.dp),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.character.chClass
                              .map((e) => Text("${e.name} ${e.level} ур."))
                              .toList(),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.dp, bottom: 10.dp),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(widget.character.description),
                          )
                        ],
                      ),
                    ),
                    characterBloc.state.currentCharacter != widget.character ?
                    Container(
                      height: 5.h,
                      width: 40.w,
                      decoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(50)),
                        color: OurColors.focusColor,),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            characterBloc.add(SelectEvent(widget.character));
                          });

                        },
                        child: const Text("Выбрать",
                          style: TextStyle(color: Colors.black),),
                      ),
                    ) : Container()
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
