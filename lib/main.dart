import 'dart:convert';

import 'package:dnd/pages/home/home_router.dart';
import 'package:dnd/routes.dart';
import 'package:dnd/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'global_vars.dart';
import 'models/user_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    runApp( const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return FlutterSizer(
      builder: (context, orientation, screenType) {
    return  MaterialApp(
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      title: 'DND Companion',
      theme: theme(),
      routes: routes,
      home: const HomeRouter(),
    );
  });}

}

