

import 'dart:convert';

import 'package:dnd/global_vars.dart';
import 'package:dnd/models/character.dart';
import 'package:flutter/cupertino.dart';

import '../models/item.dart';
import '../type_defs.dart';
import 'http_provider.dart';
Future<void> tryLogin({
  required String login,
  required String password,
  required OnHttpSuccess onSuccess,
  Map<String, dynamic>? profile,
  OnHttpError? onError,
  OnHttpFatalError? onFatalError,
  String? initUri,
  String? when,
  bool? recovery,
}) async {
  final Map<String, dynamic> _map = {
    'username': login,
    'password': password,
  };
  final String _json = json.encode(_map);
  debugPrint(_json);
  await HttpProvider().postData(
      method: 'user/auth',
      authorization: AuthorizationWay.none,
      body: _json,
      skipRenew: true,
      onSuccess: (headers, body) {
        debugPrint('accessToken... body: $body');
        if (body is Map) {
          if (body.containsKey('token')) userData.token=body["token"];
          debugPrint('guid ${userData.token}');
          if (body.containsKey('currentCharacter')) {
            userData.currentCharacter = body["currentCharacter"];
          }
          if (body['characters'] is List) {
            List<dynamic> list=body["characters"];
            userData.characters = List.generate(list.length, (index) => Character.fromJson(list[index]));
            debugPrint(userData.characters.toString());
          }
          if (body['customItems'] is List) {
            List<dynamic> list=body["customItems"];
            userData.customItems = List.generate(list.length, (index) => Item.fromJson(list[index]));
            debugPrint(userData.customItems.toString());
          }

        }


        onSuccess(headers, body);
      },
      onError: onError,
      onFatalError: onFatalError);
}
Future<void> tryChangeSelectedCharacter(
    {required OnHttpSuccess onSuccess,
      required int index,
      OnHttpError? onError,
      OnHttpFatalError? onFatalError}) async {
  final String _json = json.encode({
    "characterIndex": index
  });
  await HttpProvider().postData(
      method: 'user/changeCharacter',
      authorization: AuthorizationWay.none,
      body: _json,
      onSuccess: onSuccess,
      onError: onError,
      onFatalError: onFatalError);
}
Future<void> tryChangeCharacter(
    {required OnHttpSuccess onSuccess,
      required Character character,
      OnHttpError? onError,
      OnHttpFatalError? onFatalError}) async {
  final String _json = json.encode(character);
  await HttpProvider().putData(
      method: 'user/characters/change',
      authorization: AuthorizationWay.none,
      body: _json,
      onSuccess: onSuccess,
      onError: onError,
      onFatalError: onFatalError);
}
Future<void> tryDeleteCharacter(
    {required OnHttpSuccess onSuccess,
      required int id,
      OnHttpError? onError,
      OnHttpFatalError? onFatalError}) async {
  await HttpProvider().deleteData(
      method: 'user/characters/delete/${id}',
      authorization: AuthorizationWay.none,
      onSuccess: onSuccess,
      onError: onError,
      onFatalError: onFatalError);
}
Future<void> tryCreateCharacter(
    {required OnHttpSuccess onSuccess,
      required Character character,
      OnHttpError? onError,
      OnHttpFatalError? onFatalError}) async {
  final String _json = json.encode(character);
  await HttpProvider().postData(
      method: 'user/characters/create',
      authorization: AuthorizationWay.none,
      body: _json,
      onSuccess: onSuccess,
      onError: onError,
      onFatalError: onFatalError);
}
Future<void> tryGetClasses(
    {required OnHttpSuccess onSuccess,
      OnHttpError? onError,
      OnHttpFatalError? onFatalError}) async {
  await HttpProvider().getData(
      method: 'classes/getAll',
      authorization: AuthorizationWay.none,
      onSuccess: onSuccess,
      onError: onError,
      onFatalError: onFatalError);
}

Future<void> tryGetRaces(
    {required OnHttpSuccess onSuccess,
      OnHttpError? onError,
      OnHttpFatalError? onFatalError}) async {
  await HttpProvider().getData(
      method: 'races/getAll',
      authorization: AuthorizationWay.none,
      onSuccess: onSuccess,
      onError: onError,
      onFatalError: onFatalError);
}

Future<void> tryGetFeatures(
    {required OnHttpSuccess onSuccess,
      OnHttpError? onError,
      OnHttpFatalError? onFatalError}) async {
  await HttpProvider().getData(
      method: 'features/getAll',
      authorization: AuthorizationWay.none,
      onSuccess: onSuccess,
      onError: onError,
      onFatalError: onFatalError);
}

Future<void> tryGetSpells(
    {required OnHttpSuccess onSuccess,
      OnHttpError? onError,
      OnHttpFatalError? onFatalError}) async {
  await HttpProvider().getData(
      method: 'spells/getAll',
      authorization: AuthorizationWay.none,
      onSuccess: onSuccess,
      onError: onError,
      onFatalError: onFatalError);
}

Future<void> tryRegister({
  required String password,
  required String confirmPassword,
  required String email,
  required OnHttpSuccess onSuccess,
  OnHttpError? onError,
  OnHttpFatalError? onFatalError,
}) async {
  // final HttpProvider _httpProvider = HttpProvider();
  final Map<String, dynamic> _map = {
   "username":email,
    "password":password,
    "confirmPassword":confirmPassword
  };
  final String _json = json.encode(_map);
  debugPrint('body=$_json');
  await HttpProvider().postData(
    method: 'user/registration',
    body: _json,
    skipRenew: true,
    onSuccess: onSuccess,
    onError: onError,
    onFatalError: onFatalError,
  );
}