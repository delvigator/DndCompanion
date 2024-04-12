import 'package:dnd/components/our_colors.dart';
import 'package:dnd/pages/spells_book/all_spells.dart';
import 'package:dnd/pages/spells_book/spells_book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class SpellsPage extends StatefulWidget {
  const SpellsPage({super.key});

  @override
  State<SpellsPage> createState() => _SpellsPageState();
}

class _SpellsPageState extends State<SpellsPage> {
  int currentPage = 0;
  List<String> pageNamesAll = ["Книга заклинаний", "Все заклинания"];

  @override
  Widget build(BuildContext context) {
    List<String> pageNamesWithoutCurrent = List.from(pageNamesAll);
    pageNamesWithoutCurrent.remove(pageNamesAll[currentPage]);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 1.h),
              child: Row(children: [
                Text(
                  pageNamesAll[currentPage],
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  color: Colors.white,
                  onPressed: () async {
                    showMenu(
                      shape:  const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          )),
                      color: OurColors.focusColorTile,
                      context: context,
                      position: RelativeRect.fromLTRB(3.w, 10.h, 50, 0),
                      items: pageNamesWithoutCurrent
                          .asMap()
                          .entries
                          .map((item) => PopupMenuItem(
                                child: Text(
                                  item.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.white),
                                ),
                                onTap: () {
                                  setState(() {
                                    pageNamesWithoutCurrent = List.from(pageNamesAll);
                                    currentPage = pageNamesAll.indexOf(item.value);
                                    pageNamesWithoutCurrent
                                        .remove(pageNamesAll[currentPage]);
                                  });
                                },
                              ))
                          .toList(),
                      elevation: 8.0,
                    );
                  },
                  icon: const Icon(Icons.keyboard_arrow_down),
                ),
              ]),
            ),
           currentPage==0 ? const SpellsBookPage() : const AllSpells()
          ],
        ),
      ),
    );
  }
}
