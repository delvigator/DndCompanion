import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Item extends Equatable{
  final String name;
  final String? price;
  final int weight;
  final String type;
  final String description;
  final String? armorClass;
  final String? damage;
  final bool? interference;
  final String? strength;
  final bool equipable;
  final String rarity;

  const Item( {required this.name, this.price, required this.weight, required this.type, this.description="",
      this.armorClass, this.damage, this.interference, this.strength,required this.equipable, required this.rarity,});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'weight': weight,
      'type': type,
      'description': description,
      'armorClass': armorClass,
      'damage': damage,
      'interference': interference,
      'strength': strength,
      'equipable':equipable,
      'rarity': rarity
    };
  }

  factory Item.fromJson(Map<String, dynamic> map) {
    return Item(
      name: map['name'] as String,
      price: map['price'] ,
      weight: map['weight'] as int,
      type: map['type'] ,
      description: map['description'] ,
      armorClass: map['armorClass'] ,
      damage: map['damage'],
      equipable: map['equipable'],
      interference: map['interference'] ,
      strength: map['strength'] ,
        rarity:map['rarity']
    );
  }

  @override
  List<Object?> get props =>[name,type];
}
class ItemInInventory{
  Item item;
  int number;
  bool equip;

  ItemInInventory({required this.item, required this.number, required this.equip});

  Map<String, dynamic> toJson() {
    return {
      'item': jsonEncode(item),
      'number': number,
      'equip':equip
    };
  }

  factory ItemInInventory.fromJson(Map<String, dynamic> map) {
    return ItemInInventory(
      item: map['item'] is String ? Item.fromJson(jsonDecode(map["item"])) : Item.fromJson(map["item"]),
      number: map['number'] as int,
      equip: map['equip'] as bool
    );
  }
}