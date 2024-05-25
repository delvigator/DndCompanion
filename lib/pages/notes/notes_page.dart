import 'dart:io';

import 'package:dnd/components/default_button.dart';
import 'package:dnd/pages/notes/add_note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../bloc/character_bloc/character_bloc.dart';
import '../../components/our_colors.dart';
import '../../global_vars.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  static String routeName = "/notesPage";
  @override
  State<NotesPage> createState() => _NotesPageState();

}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TextStyle? verySmall =
    Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.dp);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Заметки"),
            //SizedBox(width: 10.w,),
            characterBloc.state.currentCharacter!=-1 ?
            Row(
              children: [

                Container(
                  width: 10.w,
                  height: 5.h,
                  decoration: const BoxDecoration(
                    color: OurColors.focusColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AddNote.routeName);
                      },
                      icon:  Icon(Icons.add,size: 17.dp,),
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
              ],
            ) : Container()
          ],
        ),
      ),
      body:BlocBuilder<CharacterBloc, CharacterState>(
    bloc: characterBloc,
    builder: (context, state) {
    return
        characterBloc.state.currentCharacter==-1 ? Center(
          heightFactor: 2.8.h,
          child: Text(
            "Сначала выберите персонажа",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.white),
          ))
          : characterBloc.state.characters[characterBloc.state.currentCharacter].notes.isEmpty ? Center(
          heightFactor: 2.8.h,
          child: Text(
            "Здесь пока ничего нет",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.white),
          ))
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
          child:  BlocBuilder<CharacterBloc, CharacterState>(
            bloc: characterBloc,
  builder: (context, state) {
    return Column(
            children: characterBloc.state.characters[characterBloc.state.currentCharacter].notes
                .map((element) => Padding(
              padding: EdgeInsets.only(
                  left: 2.w, right: 2.w, bottom: 1.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AddNote.routeName,arguments: {
                    "index":characterBloc.state.characters[characterBloc.state.currentCharacter].notes.indexOf(element)
                  });
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
                            element.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall,
                          ),
                        ],
                      ),
                       SizedBox(
                         width: 25.w,
                         height: 5.h,
                         child: Center(
                           child: element.category!=null && element.category!="" ? DefaultButton(
                             onPress: (){},
                             text: element.category!,
                           ) : Container(),
                         ),
                       )

                    ],
                  ),
                ),
              ),
            ))
                .toList(),
        );
  },
)),
        );
}
    ));
  }
}
