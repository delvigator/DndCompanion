class ChClass{
final String name;
final int level;

ChClass({required this.name, required this.level});

factory ChClass.fromJson(Map<String,dynamic> json){
  return ChClass(name: json["name"], level: json["level"]);
}
}