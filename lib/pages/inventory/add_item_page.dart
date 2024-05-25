import 'package:dnd/bloc/character_bloc/character_bloc.dart';
import 'package:dnd/bloc/information_bloc/information_bloc.dart';
import 'package:dnd/components/default_button.dart';
import 'package:dnd/global_vars.dart';
import 'package:dnd/models/item.dart';
import 'package:dnd/pages/inventory/create_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../components/our_colors.dart';
import 'item_description.dart';

bool isAdded = false;

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  static String routeName = "/addItemPage";

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  List<Item> filteredItems = List.from(
      informationBloc.state.items + informationBloc.state.customItems);
  List<String> types = [
    "Нет",
    "Предмет",
    "Доспехи",
    "Оружие",
    "Инструмент",
    "Магический предмет",
  ];

  List<String> rarity = [
    "Нет",
    "Обычный",
    "Необычный",
    "Редкий",
    "Очень редкий",
    "Легендарный",
    "Артефакт"
  ];
  int typeIndex = -1;
  int rarityIndex = -1;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    informationBloc.add(LoadItemsEvent(context));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    if (isAdded) {
      setState(() {
        filteredItems =
            informationBloc.state.customItems + informationBloc.state.items;
        isAdded = false;
      });
    }
    TextStyle? verySmall =
        Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.dp);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                height: 5.h,
                width: 30.w,
                child: DefaultButton(
                  text: "Добавить свой",
                  onPress: () {
                    Navigator.pushNamed(context, CreateItemPage.routeName);
                  },
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<InformationBloc, InformationState>(
          bloc: informationBloc,
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(top: 2.h, right: 3.w, left: 3.w),
              child: BlocListener<InformationBloc, InformationState>(
                bloc: informationBloc,
                listener: (context, state) {
                  setState(() {
                    filter();
                  });
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.dp),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        controller: nameController,
                        style: Theme.of(context).textTheme.bodySmall,
                        cursorColor: Colors.black45,
                        textAlignVertical: TextAlignVertical.center,
                        autofocus: false,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(20),
                        ],
                        decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.none),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.none),
                            ),
                            hintText: "Название",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.black45)),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.dp),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: rarityIndex == -1
                                  ? Text(
                                      "Редкость",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: Colors.black45),
                                    )
                                  : Text(
                                      rarity[rarityIndex],
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                            ),
                            PopupMenuButton(
                              color: OurColors.focusColorTile,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              )),
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              itemBuilder: (BuildContext context) => rarity
                                  .asMap()
                                  .entries
                                  .map((e) => PopupMenuItem(
                                        child: Text(
                                          e.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(color: Colors.white60),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            rarityIndex = e.key;
                                            if (e.key == 0) rarityIndex = -1;
                                          });
                                        },
                                      ))
                                  .toList(),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.dp),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: typeIndex == -1
                                  ? Text(
                                      "Тип",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: Colors.black45),
                                    )
                                  : Text(
                                      types[typeIndex],
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                            ),
                            PopupMenuButton(
                              color: OurColors.focusColorTile,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              )),
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              itemBuilder: (BuildContext context) => types
                                  .asMap()
                                  .entries
                                  .map((e) => PopupMenuItem(
                                        child: Text(
                                          e.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(color: Colors.white60),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            typeIndex = e.key;
                                            if (e.key == 0) typeIndex = -1;
                                          });
                                        },
                                      ))
                                  .toList(),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                        width: 50.w,
                        height: 5.h,
                        child: DefaultButton(
                          text: "Применить",
                          onPress: () {
                            setState(() {
                              filter();
                            });
                          },
                        )),
                    SizedBox(
                      height: 2.h,
                    ),
                    Column(
                      children: filteredItems
                          .map((element) => Padding(
                                padding: EdgeInsets.only(
                                    left: 2.w, right: 2.w, bottom: 1.h),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        ItemDescription.routeName,
                                        arguments: {"item": element});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15.dp),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              element.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            Text(
                                              element.type,
                                              style: verySmall,
                                            )
                                          ],
                                        ),
                                        !characterBloc
                                                .state
                                                .characters[characterBloc
                                                    .state.currentCharacter]
                                                .checkContainsItem(element)
                                            ? BlocBuilder<CharacterBloc,
                                                CharacterState>(
                                                bloc: characterBloc,
                                                builder: (context, state) {
                                                  return Container(
                                                    width: 10.w,
                                                    height: 5.h,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            characterBloc.add(AddItemEvent(
                                                                ItemInInventory(
                                                                    item:
                                                                        element,
                                                                    number: 1,
                                                                    equip:
                                                                        false)));
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.add,
                                                          size: 17.dp,
                                                        ),
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  filter() {
    filteredItems = [];
    String name = "";
    if (nameController.text != "") name = nameController.text;
    for (var element in informationBloc.state.items) {
      bool allTrue = true;
      if (name != "" && element.name != name) allTrue = false;
      if (typeIndex != -1 && element.type != types[typeIndex]) allTrue = false;
      if (rarityIndex != -1 && element.rarity != rarity[rarityIndex])
        allTrue = false;
      if (allTrue) filteredItems.add(element);
    }
    for (var element in informationBloc.state.customItems) {
      bool allTrue = true;
      if (name != "" && element.name != name) allTrue = false;
      if (typeIndex != -1 && element.type != types[typeIndex]) allTrue = false;
      if (rarityIndex != -1 && element.rarity != rarity[rarityIndex])
        allTrue = false;
      if (allTrue) filteredItems.add(element);
    }
  }
}
