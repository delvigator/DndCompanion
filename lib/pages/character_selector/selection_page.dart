import 'package:dnd/components/character_selector_form.dart';
import 'package:dnd/components/our_colors.dart';
import 'package:dnd/global_vars.dart';
import 'package:dnd/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Выбор персонажа"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            shape: const CircleBorder(),
            backgroundColor: OurColors.focusColorLight,
            foregroundColor: Colors.black,
            child: const Icon(Icons.add)),
        body:  SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.dp),
            child:  globalUserData.characters.isEmpty ? Center(heightFactor: 2.8.h,
                child:const Text("Нет персонажей",style: TextStyle(color: Colors.white),)) : Column(
              children: globalUserData.characters.map((unit) => CharacterSelectorForm(character: unit)).toList()
            ),
          ),
        ));
  }
}
