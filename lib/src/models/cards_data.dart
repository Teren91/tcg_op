
class CardsData {

  final String id;
  final String? code;
  final String? rarity;
  final String? type;
  final String? name;
  final String? imgUrl;
  final int? cost;
  final int? power;
  final String? counter;
  final String? color;
  final String? family;
  final String? ability;
  final String? trigger;
  final String? cardSet;

  const CardsData({
    required this.id,
    required this.code,
    required this.rarity,
    required this.type,
    required this.name,
    required this.imgUrl,
    required this.cost,
    required this.power,
    required this.counter,
    required this.color,
    required this.family,
    required this.ability,
    required this.trigger,
    required this.cardSet,
  });

  factory CardsData.fromJson(Map<String, dynamic> json) => CardsData(
    id: json['id'],
    code: json['code'],
    rarity: json['rarity'],
    type: json['type'],
    name: json['name'],
    imgUrl: json['images']['large'],
    cost: json['cost'],
    power: json['power'],
    counter: json['counter'],
    color: json['color'],
    family: json['family'],
    ability: json['ability'],
    trigger: json['trigger'],
    cardSet: json['set']['name'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'rarity': rarity,
    'type': type,
    'name': name,
    'imgUrl': imgUrl,
    'cost': cost,
    'power': power,
    'counter': counter,
    'color': color,
    'family': family,
    'ability': ability,
    'trigger': trigger,
    'cardSet': cardSet,
  };
}