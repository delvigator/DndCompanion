import 'dart:convert';

import 'package:dnd/components/extension_string.dart';

import 'character.dart';
import 'item.dart';

class User{
   String token;
   String login64='';
   String password64='';
  final int currentCharacter;
  final List<Item> customItems;
  final List<Character> characters;

  User({this.token='', required this.currentCharacter, required this.customItems, required  this.characters});

  Map<String, dynamic> toJson() {
    return {
      'login64': login64,
      'password64': password64,
      'currentCharacter': currentCharacter,
      'customItems': jsonEncode(customItems),
      "characters": characters
    };
  }
  void encodeLogin(String _login) {
    login64 = _login.encodeStringToPipe64();
  }

  String decodeLogin() {
    return login64.decodePipe64ToString();
  }

  void encodePassword(String _password) {
    password64 = _password.encodeStringToPipe64();
  }

  String decodePassword() {
    return password64.decodePipe64ToString();
  }
  factory User.fromJson(Map<String, dynamic> map) {
    List<dynamic> items =
    map["items"] is String? ? jsonDecode(map["items"]) : map["items"];
    List<dynamic> characters =
    map["characters"] is String? ? jsonDecode(map["characters"]) : map["characters"];
    return User(
      token: map['token'],
      currentCharacter: map['currentCharacter'] as int,
      customItems: List<Item>.generate(
          items.length, (index) => Item.fromJson(items[index])),
      characters: List<Character>.generate(
          characters.length, (index) => Character.fromJson(characters[index])),
    );
  }
}