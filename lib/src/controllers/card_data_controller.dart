
import 'package:flutter/material.dart';
import 'package:tcg_op/src/models/cards_data.dart';

import 'package:tcg_op/src/service/card_data_service.dart';

class CardDataController with ChangeNotifier{
  List<CardsData> _cardsDataList  = [];

  List<CardsData> get cardsDataList => _cardsDataList ;

  final _cardDataService = CardDataService();

  // Filters
  String _nameFilter = '';
  String get nameFilter => _nameFilter;
  set nameFilter(String value) {
    _nameFilter = value;
    notifyListeners();
  }

  String _codeFilter = '';
  String get codeFilter => _codeFilter;
  set codeFilter(String value) {
    _codeFilter = value;
    notifyListeners();
  }

  String _colorFilter = '';
  String get colorFilter => _colorFilter;
  set colorFilter(String value) {
    _colorFilter = value;
    notifyListeners();
  }

  int _costFilter = 0;
  int get costFilter => _costFilter;
  set costFilter(int value) {
    _costFilter = value;
    notifyListeners();
  }

  String _imageFilter = '';
  String get imageFilter => _imageFilter;
  set imageFilter(String value) {
    _imageFilter = value;
    notifyListeners();
  }

  int _powerFilter = 0;
  int get powerFilter => _powerFilter;
  set powerFilter(int value) {
    _powerFilter = value;
    notifyListeners();
  }

  Future<List<CardsData>> getAllCards(int offset) async {
    _cardsDataList = await _cardDataService.getAllCards(offset: offset);
    _applyFilters();
    return _cardsDataList;
  }

  void _applyFilters() {
    final filters = [
      (card) => _nameFilter.isEmpty || card.name.toLowerCase().contains(_nameFilter.toLowerCase()),
      (card) => _codeFilter.isEmpty || card.code.toLowerCase().contains(_codeFilter.toLowerCase()),
      (card) => _colorFilter.isEmpty || card.color.toLowerCase().contains(_colorFilter.toLowerCase()),
      (card) => _costFilter == 0 || card.cost == _costFilter,
      (card) => _imageFilter.isEmpty || card.imgUrl.toLowerCase().contains(_imageFilter.toLowerCase()),
      (card) => _powerFilter == 0 || card.power == _powerFilter,
    ];

    _cardsDataList = _cardsDataList
        .where((card) => filters.every((filter) => filter(card)))
        .toList();
    notifyListeners();
  }
}
