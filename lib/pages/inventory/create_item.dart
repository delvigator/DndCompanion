import 'package:dnd/bloc/information_bloc/information_bloc.dart';
import 'package:dnd/components/default_button.dart';
import 'package:dnd/components/snack_bar.dart';
import 'package:dnd/global_vars.dart';
import 'package:dnd/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../components/our_colors.dart';
import 'add_item_page.dart';

class CreateItemPage extends StatefulWidget {
  const CreateItemPage({super.key});

  static String routeName = "/createItemPage";

  @override
  State<CreateItemPage> createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  bool canEquip = false;
  List<String> types = [
    "Предмет",
    "Доспехи",
    "Оружие",
    "Инструмент",
    "Магический предмет",
  ];

  List<String> rarity = [
    "Обычный",
    "Необычный",
    "Редкий",
    "Очень редкий",
    "Легендарный",
    "Артефакт"
  ];
  int typeIndex = -1;
  int rarityIndex = -1;

  int maxLengthNameItem = 20;
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final maxLengthDescription = 500;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.dp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  buildCounter: (context,
                          {required currentLength,
                          required isFocused,
                          maxLength}) =>
                      const SizedBox(),
                  maxLength: maxLengthNameItem,
                  controller: nameController,
                  style: Theme.of(context).textTheme.bodySmall,
                  cursorColor: Colors.black45,
                  textAlignVertical: TextAlignVertical.center,
                  autofocus: false,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: "Название",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black45)),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.all(5.dp),
                child: Text(
                  "${nameController.text.length}/$maxLengthNameItem",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
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
                                style: Theme.of(context).textTheme.bodySmall,
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
                                style: Theme.of(context).textTheme.bodySmall,
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
              Row(
                children: [
                  Container(
                    width: 30.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.dp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      controller: weightController,
                      style: Theme.of(context).textTheme.bodySmall,
                      cursorColor: Colors.black45,
                      textAlignVertical: TextAlignVertical.center,
                      autofocus: false,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                          hintText: "Вес",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black45)),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "фнт.",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
              SizedBox(height: 2.h,),
              Row(
                children: [
                  Text(
                    "Можно экипировать: ",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                    width: 24.dp,
                    height: 24.dp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                        checkColor: Colors.black,
                        activeColor: Colors.transparent,
                        tristate: false,
                        value: canEquip,
                        onChanged: (bool? value) {
                          setState(() {
                            canEquip = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
SizedBox(height: 2.h,),
              Container(
                padding: EdgeInsets.all(10.dp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  controller: descriptionController,
                  maxLength: maxLengthDescription,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus
                        ?.unfocus();
                  },
                  buildCounter: (context,
                      {required currentLength,
                        required isFocused,
                        maxLength}) =>
                  const SizedBox(),
                  style: Theme.of(context).textTheme.bodySmall,
                  cursorColor: Colors.black45,
                  textAlignVertical: TextAlignVertical.center,
                  autofocus: false,
                  maxLines: 10,
                  decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.white),
                      ),
                      hintText: "Описание",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black45)),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.all(5.dp),
                child: Text(
                  "${descriptionController.text.length}/$maxLengthDescription",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(height:3.h),
              Container(
                height: 5.h,
                  child: DefaultButton(text: "Добавить",onPress: (){
                    if(nameController.text==""){
                      showSnackBar("Введите название");
                    }
                    else if(typeIndex==-1){
                      showSnackBar("Выберите тип");
                    }
                    else if(rarityIndex==-1){
                      showSnackBar("Выберите редкость");
                    }
                    else{
                      Item item=Item(name: nameController.text, weight: int.parse(weightController.text), type: types[typeIndex], equipable: canEquip, rarity: rarity[rarityIndex],description: descriptionController.text);
                      informationBloc.add(AddCustomItemsEvent(item));
                      Navigator.of(context).pop();
                      isAdded=true;
                    }
                  },))
            ],
          ),
        ),
      ),
    );
  }
}
