
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcg_op/src/models/cards_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CardDataService {

  static const String _baseUrl = 'https://www.apitcg.com/api/one-piece/cards';
  static final String _apiKey = dotenv.env['API_KEY']!;

  static const String _cacheKey = 'cards_cache';

  Future<List<CardsData>> getAllCards({int offset = 0}) async {
   List<CardsData> cards = [];

   try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? cachedData = prefs.getString(_cacheKey);

      // if(cachedData != null)
      // {
      //   final List<dynamic> decodedData = jsonDecode(cachedData);
      //   final List<CardsData> cardsData = decodedData.map((e) => CardsData.fromJson(e)).toList();
      //   return cardsData;
      // }

      Uri basicUrl = Uri.https(
        'www.apitcg.com', 
        '/api/one-piece/cards',
        //{'property': 'id', 'value': '-'}
        {'id': '-'}
      ); //Propiedad genérica para obtener todos los datos
  
      final response = await http.get(
        basicUrl, 
        headers:{'x-api-key': _apiKey}
      );

     if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final cardDataList = jsonResponse['data'] as List;
        cards = cardDataList.map((cardData) => CardsData.fromJson(cardData)).toList();
        prefs.setString(_cacheKey, jsonEncode(cards));
     }
   } catch (e) {

     rethrow;
   }

   return cards;
  }

  Future<CardsData?> getCardByname(String name) async {
    CardsData? card;

    final nameLowerCase = name.toLowerCase();
    try{
      final url = Uri.parse('$_baseUrl?name=$nameLowerCase');
      final response = await http.get(url);
      
      if(response.statusCode == 200){
        final cardData = json.decode(response.body);
        card = CardsData.fromJson(cardData);
      }
    }
    catch(e){
      rethrow;
    }
    return card;
  }

  Future<List<CardsData>> getCardByCode(String code) async {
    List<CardsData> cards = [];

    try {
      final url = Uri.parse('$_baseUrl?code=$code');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body)['data'] as List;
        cards = jsonResponse.map((e) => CardsData.fromJson(e)).toList();
      }
    } catch (e) {
      rethrow;
    }

    return cards;
  }

  Future<List<CardsData>> getCardByColor(String color) async {
    List<CardsData> cards = [];

    try {
      final url = Uri.parse('$_baseUrl?color=$color');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body)['data'] as List;
        cards = jsonResponse.map((e) => CardsData.fromJson(e)).toList();
      }
    } catch (e) {
      rethrow;
    }

    return cards;
  }

  Future<List<CardsData>> getCardByCost(int cost) async {
    List<CardsData> cards = [];

    try {
      final url = Uri.parse('$_baseUrl?cost=$cost');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body)['data'] as List;
        cards = jsonResponse.map((e) => CardsData.fromJson(e)).toList();
      }
    } catch (e) {
      rethrow;
    }

    return cards;
  }

    Future<List<CardsData>> getCardByPower(int power) async {
    List<CardsData> cards = [];

    try {
      final url = Uri.parse('$_baseUrl?cost=$power');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body)['data'] as List;
        cards = jsonResponse.map((e) => CardsData.fromJson(e)).toList();
      }
    } catch (e) {
      rethrow;
    }

    return cards;
  }
  
}