import 'package:dnd/bloc/character_bloc/character_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../components/our_colors.dart';
import '../../global_vars.dart';
import '../../models/item.dart';
import 'item_description.dart';
bool changed=false;
class Equipment extends StatefulWidget {
  const Equipment({super.key});

  @override
  State<Equipment> createState() => _EquipmentState();
}

class _EquipmentState extends State<Equipment> {
  void buildItems(){
    armor=[];
    weapon=[];
    other=[];
    for (var element in characterBloc.state.characters[characterBloc.state.currentCharacter].items) {
      if(element.equip && element.item.type=="Доспехи" && !armor.contains(element.item)) armor.add(element.item);
      if(element.equip && element.item.type=="Оружие" && !weapon.contains(element.item)) weapon.add(element.item);
      if(element.equip && element.item.type!="Доспехи" && element.item.type!="Оружие" && !other.contains(element.item)) other.add(element.item);
      changed=false;
    }
    }
  List<Item> armor=[];
  List<Item> weapon=[];
  List<Item> other=[];

  @override
  Widget build(BuildContext context) {
    TextStyle? verySmall =
    Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.dp);
    if(armor.isEmpty || weapon.isEmpty || other.isEmpty || changed){
        buildItems();
setState(() {
});
    }

    return SingleChildScrollView(
      child: BlocListener<CharacterBloc, CharacterState>(
        bloc: characterBloc,
  listener: (context, state) {
   setState(() {
     buildItems();
   });
  },
  child: Padding(
        padding:  EdgeInsets.only(top: 6.h, left: 2.w),
        child: BlocBuilder<CharacterBloc, CharacterState>(
          bloc: characterBloc,
  builder: (context, state) {
    return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Доспехи:",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),

              ],
            ),
            SizedBox(height: 2.h,),
            Column(
              children: armor.map((element) =>    GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                      ItemDescription.routeName,
                      arguments: {"item": element});
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
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
                            Text(element.name,style: Theme.of(context).textTheme.bodySmall,),
                            Text(element.type,style: verySmall,)
                          ],
                        ),
                        Row(children:[Container(
                          decoration: BoxDecoration(
                            color: OurColors.lightPink,
                            borderRadius: BorderRadius.circular(20),
                          ),

                        ),
                          SizedBox(width: 5.w,),

                        ])],
                    ),
                  ),
                ),
              )).toList(),
            ),

            SizedBox(height: 4.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Оружие: ",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),

              ],
            ),
            SizedBox(height: 2.h,),
            Column(
              children: weapon.map((element) =>    GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                      ItemDescription.routeName,
                      arguments: {"item": element});
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
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
                            Text(element.name,style: Theme.of(context).textTheme.bodySmall,),
                            Text(element.type,style: verySmall,)
                          ],
                        ),
                        Row(children:[Container(
                          decoration: BoxDecoration(
                            color: OurColors.lightPink,
                            borderRadius: BorderRadius.circular(20),
                          ),

                        ),
                          SizedBox(width: 5.w,),

                        ])],
                    ),
                  ),
                ),
              )).toList(),
            ),

            SizedBox(height: 4.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Другое:",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),

              ],
            ),
            SizedBox(height: 2.h,),
            Column(
              children: other.map((element) =>    GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                      ItemDescription.routeName,
                      arguments: {"item": element});
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
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
                            Text(element.name,style: Theme.of(context).textTheme.bodySmall,),
                            Text(element.type,style: verySmall,)
                          ],
                        ),
                        Row(children:[Container(
                          decoration: BoxDecoration(
                            color: OurColors.lightPink,
                            borderRadius: BorderRadius.circular(20),
                          ),

                        ),
                          SizedBox(width: 5.w,),

                        ])],
                    ),
                  ),
                ),
              )).toList(),
            )
          ],
        );
  },
),
      ),
),
    );
  }
}
