import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreationRace extends StatefulWidget {
  const CreationRace({super.key});
  static String routeName = "/creationRace";
  @override
  State<CreationRace> createState() => _CreationRaceState();
}

class _CreationRaceState extends State<CreationRace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создание персонажа"),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
    );
  }
}
