import 'package:dnd/components/our_colors.dart';
import 'package:flutter/material.dart';

Future<void> showMyDialog(String title,String text,Function (BuildContext context)onPressed, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title,style: Theme.of(context).textTheme.bodyMedium,),
        content: Text(text,style: Theme.of(context).textTheme.bodySmall,),
        actions:  <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: OurColors.focusColorLight)
            ),
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Отмена'),
          ),
          TextButton(
            style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: OurColors.focusColorLight)
            ),
            onPressed:()=> onPressed(context),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}