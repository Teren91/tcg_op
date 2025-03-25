
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcg_op/src/models/cards_data.dart';
import 'package:tcg_op/src/models/deck_data.dart';

class DeckDataService extends ChangeNotifier{
  Deck? _deck;
  CardsData? _leaderCard;
  final List<CardsData> _selectedCards = [];
  List<Deck> _savedDecks = [];

  Deck? get currentDeck => _deck;
  CardsData? get leaderCard => _leaderCard;
  List<CardsData> get selectedCards => _selectedCards;
  List<Deck> get savedDecks => _savedDecks;

  //Restrictions
  static const int maxNonLeaderCards = 50;
  static const int maxCardCopies = 4;

  void addCardToDeck(CardsData card) {
    if(card.type == 'LEADER') {
      _leaderCard ??= card;
    }
    else{
      if(_selectedCards.length < maxNonLeaderCards) {
        int count = _selectedCards.where((card) => card.id == card.id).length;
        if(count < maxCardCopies) {
          _selectedCards.add(card);
        }
      }
    }
    notifyListeners();
  }

  void removeCardFromDeck(CardsData card) {
    if(card.type == 'LEADER') {
      _leaderCard = null;
    }
    else{
      _selectedCards.remove(card);
    }
    notifyListeners();
  }

  void createDeck(String name) async {
    if(_savedDecks.any((deck) => deck.name == name)) {
      throw Exception('Deck with name $name already exists');
    }

    if(!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(name))
    {
      throw Exception('Deck name can only contain letters, numbers, hyphens and underscores');
    }

    if(_leaderCard == null) {
      throw Exception('Deck must have a leader card');
    }

    if(_leaderCard != null) {
      _deck = Deck(
        name: name,
        leaderCard: _leaderCard,
        cards: _selectedCards,
      );
      _savedDecks.add(_deck!);
      _leaderCard = null;
      _selectedCards.clear();
      await _savedDecksToPrefs();
      notifyListeners();
    }
  }

  void clearDeck() {
    _deck = null;
    _leaderCard = null;
    _selectedCards.clear();
    notifyListeners();
  }

  //SharedPreferences
  Future<void> _savedDecksToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final decksJson = _savedDecks.map((deck) => deck.toJson()).toList();
    prefs.setStringList(
      'decks', 
      decksJson
        .map((json) => jsonEncode(json))
        .toList()
    );
  }

  Future <void> loadDecksFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final decksJson = prefs.getStringList('decks') ?? [];
    _savedDecks = decksJson.map((json) => Deck.fromJson(jsonDecode(json))).toList();

    notifyListeners();
  }
}