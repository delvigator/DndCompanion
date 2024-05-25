import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../bloc/character_bloc/character_bloc.dart';
import '../../components/default_button.dart';
import '../../global_vars.dart';
import '../../models/item.dart';
import 'equipment.dart';

class ItemDescription extends StatefulWidget {
  const ItemDescription({super.key});
  static String routeName = "/itemDescription";
  @override
  State<ItemDescription> createState() => _ItemDescriptionState();
}

class _ItemDescriptionState extends State<ItemDescription> {
  @override
  Widget build(BuildContext context) {
    TextStyle? medium =
    Theme
        .of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(color: Colors.white);
    final args = (ModalRoute
        .of(context)
        ?.settings
        .arguments ??
        <String, dynamic>{}) as Map;
    Item item = args["item"];
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CharacterBloc, CharacterState>(
          bloc: characterBloc,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                characterBloc.state.currentCharacter != -1 ?
                SizedBox(
                    width: 35.w,
                    height: 5.h,
                    child: characterBloc.state.characters[characterBloc.state
                        .currentCharacter].getByItem(item) != null &&
                        characterBloc.state.characters[characterBloc.state
                            .currentCharacter]
                            .getByItem(item)
                            ?.equip == false && item.equipable ? DefaultButton(
                      text: 'Экипировать',
                      onPress: () {
                        setState(() {
                          changed=true;
                          characterBloc.add(EquipItemEvent(characterBloc.state.characters[characterBloc.state
                              .currentCharacter]
                              .getByItem(item)!));
                          //characterBloc.state.currentSpells.remove(spell);
                        });
                      },
                    ) : characterBloc.state.characters[characterBloc.state
                        .currentCharacter]
                        .getByItem(item)
                        ?.equip == true
              ? DefaultButton(
                      text: 'Снять',
                      onPress: () {
                        setState(() {
                          changed=true;
                          characterBloc.add(DisequipItemEvent(characterBloc.state.characters[characterBloc.state
                              .currentCharacter]
                              .getByItem(item)!));
                          // characterBloc.state.currentSpells.add(spell);
                        });
                      },
                    ) : Container()
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
                      item.name,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge,
                    ),
                  ),
                  Text(
                    "Тип: ${item.type}",
                    style: medium,
                  ),
                  Text(
                    "Редкость: ${item.rarity}",
                    style: medium,
                  ),
                  Text(
                    "Вес: ${item.weight} фнт.",
                    style: medium,
                  ),
                  //item.price!=null ? Text("Цена: ${item.price}", style: medium,) : Container(),
                  item.armorClass!=null ? Text("Класс брони: ${item.armorClass}", style: medium) : Container(),
                  item.damage!=null ? Text("Урон: ${item.damage}", style: medium) : Container(),
                  item.strength!=null ? Text("Необходимая Сила: ${item.strength}", style: medium) : Container(),
                  Text("Описание: ${item.description}", style: medium)

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
