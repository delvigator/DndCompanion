import 'character.dart';

class UserData{
  List<Character> characters=[];

  UserData({required this.characters});
  factory UserData.fromJson(List<dynamic> list){
    return UserData(characters: List<Character>.generate(list.length, (index) => Character.fromJson(list[index])));
  }
}