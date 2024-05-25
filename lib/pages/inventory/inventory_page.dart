import 'package:dnd/components/default_button.dart';
import 'package:dnd/components/our_colors.dart';
import 'package:dnd/pages/inventory/add_item_page.dart';
import 'package:dnd/pages/inventory/equipment.dart';
import 'package:dnd/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../global_vars.dart';
import 'all_items.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  int mod = 1;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(characterBloc.state.currentCharacter!=-1) {
      readInfo();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Инвентарь"),
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
                        Navigator.pushNamed(context, AddItem.routeName);
                      },
                      icon:  Icon(Icons.add,size: 17.dp,),
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                // Container(
                //   width: 10.w,
                //   height: 5.h,
                //   decoration: const BoxDecoration(
                //     color: OurColors.focusColor,
                //     shape: BoxShape.circle,
                //   ),
                //   child: Center(
                //     child: IconButton(
                //       onPressed: () {},
                //       icon:  Icon(Icons.filter_alt,size: 17.dp,),
                //       color: Colors.black,
                //     ),
                //   ),
                // )
              ],
            ) : Container()
          ],
        ),
      ),
      body: characterBloc.state.currentCharacter==-1 ? Center(
        heightFactor: 2.8.h,
        child: Text(
          "Сначала выберите персонажа",
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.white),
        ))
        :SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      width: 30.w,
                      height: 5.h,
                      child: DefaultButton(
                        text: "Снаряжение",
                        onPress: () {
                          setState(() {
                            mod = 1;
                          });
                        },
                        primaryColor: mod == 1
                            ? OurColors.lightPink
                            : OurColors.focusColor,
                      )),
                  SizedBox(
                    width: 2.w,
                  ),
                  Container(
                      width: 30.w,
                      height: 5.h,
                      child: DefaultButton(
                          text: "Предметы",
                          onPress: () {
                            setState(() {
                              mod = 2;
                            });
                          },
                          primaryColor: mod == 2
                              ? OurColors.lightPink
                              : OurColors.focusColor))
                ],
              ),
              mod==1 ? Equipment() : AllItems()
            ],
          ),
        ),
      ),
    );
  }
}
