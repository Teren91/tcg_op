import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tcg_op/src/models/cards_data.dart';

class LocalCardDataService {
  static const String _localDataPath = 'assets/data/cards.json';

  Future<List<CardsData>> getAllCards() async {
    List<CardsData> cards = [];

    try {
      final String response = await rootBundle.loadString(_localDataPath);
      final jsonResponse = json.decode(response);

      final cardDataList = jsonResponse['data'] as List;
      cards = cardDataList.map((cardData) => CardsData.fromJson(cardData)).toList();
    } catch (e) {
      // Manejo de errores (opcional)
      print('Error al cargar los datos locales: $e');
    }

    return cards;
  }

  // ... (implementar otros métodos según sea necesario)

  Future<CardsData?> getCardByname(String name) async {
    // Implementar la lógica para buscar por nombre en el archivo local (opcional)
    throw UnsupportedError('No implementado para datos locales');
  }

  Future<List<CardsData>> getCardByCode(String code) async {
    // Implementar la lógica para buscar por código en el archivo local (opcional)
    throw UnsupportedError('No implementado para datos locales');
  }

  Future<List<CardsData>> getCardByColor(String color) async {
    // Implementar la lógica para buscar por color en el archivo local (opcional)
    throw UnsupportedError('No implementado para datos locales');
  }

  Future<List<CardsData>> getCardByCost(int cost) async {
    // Implementar la lógica para buscar por costo en el archivo local (opcional)
    throw UnsupportedError('No implementado para datos locales');
  }

  Future<List<CardsData>> getCardByPower(int power) async {
    // Implementar la lógica para buscar por poder en el archivo local (opcional)
    throw UnsupportedError('No implementado para datos locales');
  }
}