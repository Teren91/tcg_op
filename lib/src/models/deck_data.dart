
import 'package:tcg_op/src/models/cards_data.dart';
import 'package:uuid/uuid.dart';

class Deck {
  final String id;
  final String name;
  final CardsData? leaderCard; //Leader can be null
  final List<CardsData> cards;

  Deck({
    String? id,
    required this.name,
    required this.leaderCard,
    required this.cards,
  }) : id = id ?? const Uuid().v4();

  factory Deck.fromJson(Map<String, dynamic> json) => Deck(
    id: json['id'],
    name: json['name'],
    leaderCard: json['leaderCard'] != null
      ? CardsData.fromJson(json['leaderCard'])
      : null,
    cards: (json['cards'] as List)
      .map((e) => CardsData.fromJson(e))
      .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'leaderCard': leaderCard?.toJson(),
    'cards': cards.map((e) => e.toJson()).toList(),
  };
}