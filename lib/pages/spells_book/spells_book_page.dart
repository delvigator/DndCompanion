import 'package:flutter/cupertino.dart';

class SpellsBookPage extends StatefulWidget {
  const SpellsBookPage({super.key});

  @override
  State<SpellsBookPage> createState() => _SpellsBookPageState();
}

class _SpellsBookPageState extends State<SpellsBookPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Заклинания"),);
  }
}
