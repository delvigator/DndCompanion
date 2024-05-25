

import 'package:dnd/global_vars.dart';
import 'package:dnd/pages/inventory/inventory_page.dart';
import 'package:dnd/pages/notes/notes_page.dart';
import 'package:dnd/pages/spells_book/spells_page.dart';
import 'package:dnd/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/information_bloc/information_bloc.dart';
import '../character_list/character_list_page.dart';
import '../character_selector/selection_page.dart';
int selectedIndex = 0;
class HomeRouter extends StatefulWidget {
  const HomeRouter({super.key,});

  @override
  State<HomeRouter> createState() => _HomeRouterState();
}

class _HomeRouterState extends State<HomeRouter> {
  @override
  void initState() {
    //informationBloc.add(LoadClassesEvent(context));
    // setState(() {
    //   readPrefs(context);
    // });

    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:_getBody(selectedIndex),
      bottomNavigationBar:
      BottomNavigationBar(
        key: scaffoldKey,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        onTap: (index) => _onItemTapped(index),
        items: [ 
          BottomNavigationBarItem(
               label: '',
              activeIcon: SvgPicture.asset("assets/icons/character_selected_icon.svg"),
              icon: SvgPicture.asset("assets/icons/character_icon.svg")),
          BottomNavigationBarItem(
              label: '',
              activeIcon: SvgPicture.asset("assets/icons/book_selected_icon.svg"),
              icon: SvgPicture.asset("assets/icons/book_icon.svg")),
          BottomNavigationBarItem(
              label: '',
              activeIcon: SvgPicture.asset("assets/icons/list_selected_icon.svg") ,
              icon: SvgPicture.asset("assets/icons/list_icon.svg")),
          BottomNavigationBarItem(
              label: '',
              activeIcon: SvgPicture.asset("assets/icons/bag_selected_icon.svg"),
              icon: SvgPicture.asset("assets/icons/bag_icon.svg")),
          BottomNavigationBarItem(
              label: '',
              activeIcon: SvgPicture.asset("assets/icons/page_selected_icon.svg"),
              icon: SvgPicture.asset("assets/icons/page_icon.svg"))
        
      ],
      ),
    );

  }
  Widget _getBody(int index) {
    Widget? _body;
    switch (index) {
      case 0:
        _body = const SelectionPage();
        break;
      case 1:
        _body = const SpellsPage();
        break;
      case 2:
        _body = const CharacterListPage();
        break;
      case 3:
        _body = const InventoryPage();
        break;
      case 4:
        _body = const NotesPage();
        break;

    }
    return _body ?? Container();
}}
