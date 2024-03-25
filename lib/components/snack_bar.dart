import 'package:dnd/components/our_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../global_vars.dart';

Future<void> showSnackBar(String text,
    {Function()? onVisible, double? width, int? delay}) async {
  final ScaffoldMessengerState scaffoldMessenger =
  ScaffoldMessenger.of(navKey.currentContext!);
  scaffoldMessenger.removeCurrentSnackBar();
  scaffoldMessenger.showSnackBar(SnackBar(
    backgroundColor: OurColors.focusColorTile,
    content: Text(text, style: TextStyle(color: Colors.white, fontSize: 8.dp)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.dp)),
    elevation: 0,
    width: width,
    behavior: SnackBarBehavior.floating,
    onVisible: onVisible,
  ));
    }