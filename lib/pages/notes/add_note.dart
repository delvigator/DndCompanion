import 'package:dnd/bloc/character_bloc/character_bloc.dart';
import 'package:dnd/components/alert_dialog.dart';
import 'package:dnd/components/default_button.dart';
import 'package:dnd/components/snack_bar.dart';
import 'package:dnd/global_vars.dart';
import 'package:dnd/pages/notes/notes_page.dart';
import 'package:dnd/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../components/our_colors.dart';
import '../../models/note.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  static String routeName = "/addNotePage";

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  List<String> category = [
    "Персонаж",
    "История",
    "Сюжет",
    "Компаньоны",
    "Другое",
  ];

  int typeIndex = -1;

  TextEditingController nameController = TextEditingController();
  int nameMaxLength = 30;

  TextEditingController textController = TextEditingController();

//  int maxLengthText=2000;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    int? index = args["index"];
    debugPrint("index: $index");
    if (index != null &&
        index != -1 &&
        nameController.text == "" &&
        typeIndex == -1 &&
        textController.text == "") {
      setState(() {
        nameController.text = characterBloc
            .state
            .characters[characterBloc.state.currentCharacter]
            .notes[index]
            .title;
        textController.text = characterBloc.state
            .characters[characterBloc.state.currentCharacter].notes[index].text;
        if (characterBloc.state.characters[characterBloc.state.currentCharacter]
                .notes[index].category !=
            null) {
          typeIndex = category.indexOf(characterBloc
              .state
              .characters[characterBloc.state.currentCharacter]
              .notes[index]
              .category!);
        } else {
          typeIndex = -1;
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                index != null && index != -1
                    ? Container(
                        width: 15.w,
                        height: 5.h,
                        decoration: const BoxDecoration(
                          color: OurColors.focusColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              showMyDialog("Удалить эту запись?", "", (context){
                                characterBloc.add(DeleteNoteEvent(characterBloc
                                    .state
                                    .characters[
                                characterBloc.state.currentCharacter]
                                    .notes[index]));
                               Navigator.pop(context);
                                Navigator.pop(context);
                              }, context);

                            },
                            icon: const Center(
                                child: Icon(
                              Icons.delete,
                              color: Colors.black,
                            )),
                          ),
                        ),
                      )
                    : Container(),
                Container(
                  width: 15.w,
                  height: 5.h,
                  decoration: const BoxDecoration(
                    color: OurColors.focusColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: PopupMenuButton(
                      color: OurColors.focusColorTile,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      )),
                      icon: const Icon(
                        Icons.bookmark,
                        color: Colors.black,
                      ),
                      itemBuilder: (BuildContext context) => category
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
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Container(
                  width: 30.w,
                  height: 5.h,
                  decoration: const BoxDecoration(
                    color: OurColors.focusColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: DefaultButton(
                        text: "Сохранить",
                        onPress: () {
                          if(nameController.text=="")
                            {
                              showSnackBar("Введите заголовок");
                            }
                         else if (index != null && index != -1) {
                            characterBloc.add(SaveNoteEvent(
                                characterBloc
                                    .state
                                    .characters[
                                        characterBloc.state.currentCharacter]
                                    .notes[index],
                                Note(
                                    title: nameController.text,
                                    text: textController.text,
                                    category: typeIndex != -1
                                        ? category[typeIndex]
                                        : null)));
                          } else {
                            characterBloc.add(AddNoteEvent(Note(
                                title: nameController.text,
                                text: textController.text,
                                category: typeIndex != -1
                                    ? category[typeIndex]
                                    : null)));
                            Navigator.pop(context);
                          }

                        }),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.dp),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  controller: nameController,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                  cursorColor: Colors.white,
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
                      hintText: "Название",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white60)),
                ),
              ),

              SizedBox(
                height: 2.h,
              ),

              Container(
                padding: EdgeInsets.all(10.dp),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  controller: textController,
                  //maxLength: maxLengthText,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  // buildCounter: (context,
                  //     {required currentLength,
                  //       required isFocused,
                  //       maxLength}) =>
                  // const SizedBox(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                  cursorColor: Colors.white,
                  textAlignVertical: TextAlignVertical.center,
                  autofocus: false,
                  maxLines: 30,
                  decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(style: BorderStyle.none),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(style: BorderStyle.none),
                      ),
                      hintText: "Введите текст",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white30)),
                ),
              ),
              // Container(
              //   alignment: Alignment.topRight,
              //   padding: EdgeInsets.all(5.dp),
              //   child: Text(
              //     "${textController.text.length}/$maxLengthText",
              //     style: Theme.of(context)
              //         .textTheme
              //         .bodySmall
              //         ?.copyWith(color: Colors.white),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
