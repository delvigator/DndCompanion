import 'package:dnd/bloc/character_bloc/character_bloc.dart';
import 'package:dnd/components/default_button.dart';
import 'package:dnd/global_vars.dart';
import 'package:dnd/pages/spells_book/spells_book_page.dart';
import 'package:dnd/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../models/magic_spell.dart';

class SpellDescription extends StatefulWidget {
  const SpellDescription({super.key});

  static String routeName = "/spellDescription";

  @override
  State<SpellDescription> createState() => _SpellDescriptionState();
}

class _SpellDescriptionState extends State<SpellDescription> {
  @override
  Widget build(BuildContext context) {
    TextStyle? medium =
        Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white);
    final args = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    MagicSpell spell = args["spell"];
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CharacterBloc, CharacterState>(
          bloc: characterBloc,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                characterBloc.state.currentCharacter!=-1 ?
                SizedBox(
                    width: 35.w,
                    height: 5.h,
                    child: characterBloc.state.characters[characterBloc.state.currentCharacter].knownSpells.contains(spell) ? DefaultButton(
                      text: 'Удалить из книги',
                      onPress: () {
                        setState(() {
                          characterBloc.add(DeleteKnownSpellEvent(spell));
                          //characterBloc.state.currentSpells.remove(spell);
                        });

                      },
                    ) : DefaultButton(
                  text: 'Добавить в книгу',
                  onPress: () {
                    setState(() {
                      characterBloc.add(AddKnownSpellEvent(spell));
                     // characterBloc.state.currentSpells.add(spell);
                    });

                  },
                )
               ) :
                Container()
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<CharacterBloc, CharacterState>(
          bloc: characterBloc,
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20.dp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: Text(
                      spell.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  spell.level != 0
                      ? Text(
                          "${spell.level} уровень. ${spell.school}",
                          style: medium,
                        )
                      : Text(
                          "Фокус. ${spell.school}",
                          style: medium,
                        ),
                  Text(
                    "Дистанция: ${spell.distance}",
                    style: medium,
                  ),
                  Text(
                    "Время накладывания: ${spell.timeApplication}",
                    style: medium,
                  ),
                  Text(
                    "Длительность: ${spell.timeAction}",
                    style: medium,
                  ),
                  Text(
                    "Компоненты: ${spell.spellComponents.keys}",
                    style: medium,
                  ),
                  Text(
                    "Классы: ${spell.classes.map((e) => e)}",
                    style: medium,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text(
                      spell.description,
                      style: medium,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
