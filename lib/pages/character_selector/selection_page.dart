import 'dart:convert';

import 'package:dnd/bloc/character_bloc/character_bloc.dart';
import 'package:dnd/components/character_selector_form.dart';
import 'package:dnd/components/our_colors.dart';
import 'package:dnd/global_vars.dart';
import 'package:dnd/models/user_data.dart';
import 'package:dnd/pages/character_selector/character_creation/creation_race.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';


class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  static String routeName = "/characterSelection";

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Выбор персонажа"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CreationRace.routeName);
            },
            shape: const CircleBorder(),
            backgroundColor: OurColors.focusColorLight,
            foregroundColor: Colors.black,
            child: const Icon(Icons.add)),
        body: BlocBuilder<CharacterBloc, CharacterState>(
          bloc: characterBloc,
          builder: (context, state) {
            characterBloc.add(LoadDataEvent(context));
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.dp),
                child: characterBloc.state.characters!.isEmpty
                    ? Center(heightFactor: 2.8.h,
                    child: const Text(
                      "Нет персонажей", style: TextStyle(color: Colors.white),))
                    : Column(
                    children: characterBloc.state.characters!.map((unit) =>
                        CharacterSelectorForm(character: unit)).toList()
                ),
              ),
            );
          },
        ));
  }
}
