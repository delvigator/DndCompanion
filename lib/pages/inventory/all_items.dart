import 'dart:io';

import 'package:dnd/bloc/character_bloc/character_bloc.dart';
import 'package:dnd/global_vars.dart';
import 'package:dnd/pages/inventory/item_description.dart';
import 'package:dnd/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../components/our_colors.dart';

class AllItems extends StatefulWidget {
  const AllItems({super.key});

  @override
  State<AllItems> createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    TextStyle? verySmall =
    Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.dp);
    return BlocBuilder<CharacterBloc, CharacterState>(
      bloc: characterBloc,
  builder: (context, state) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 1.w),
      child: Column(
children: characterBloc.state.characters[characterBloc.state.currentCharacter].items.map((element) =>
    GestureDetector(
  onTap: () {
    Navigator.of(context).pushNamed(
        ItemDescription.routeName,
        arguments: {"item": element.item});
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
                Text(element.item.name,style: Theme.of(context).textTheme.bodySmall,),
                Text(element.item.type,style: verySmall,)
              ],
            ),
         Row(children:[Container(
    decoration: BoxDecoration(
    color: OurColors.lightPink,
        borderRadius: BorderRadius.circular(20),
),
    child: Row(
      children: [
        SizedBox(
          height: 4.h,
          width: 8.w,
          child: TextButton(
            onPressed: (){
              setState(() {
                if(element.number!=0) {
                  element.number--;
                }
              });
            },
            child: Icon(
              Icons.remove,
              color: Colors.black,
              size: 10.dp,
            ),
          ),
        ),
        Text(
         element.number.toString(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Container(
          alignment: Alignment.center,
          height: 4.h,
          width: 8.w,
          child: TextButton(
            onPressed: (){
              setState(() {
                element.number++;
              });
            },
            child: Icon(Icons.add, color: Colors.black, size: 10.dp),
          ),
        ),
      ],
    ),
),
            SizedBox(width: 5.w,),
            SizedBox(
              width: 10.w,
              height: 5.h,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      characterBloc.add(DeleteItemEvent(element));
                    });

                  },
                  icon:  Icon(Icons.close,size: 17.dp,),
                  color: Colors.black,
                ),
              ),
            ),
          ])],
        ),
    ),
  ),
),).toList(),
      ),
    );
  },
);
  }
}
