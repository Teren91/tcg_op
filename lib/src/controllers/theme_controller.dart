import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



//Utilidad para controlar el cambio de color (claro/oscuro)
class ThemeController with ChangeNotifier{
  late ThemeData _themeData;

  late SharedPreferences prefs;

  ThemeData dark = ThemeData.dark().copyWith();
  ThemeData light = ThemeData.light().copyWith();

  ThemeController(bool isDarkThemeOn)
  {
    _themeData = isDarkThemeOn ? dark : light;
  }

  ThemeData get themeData => _themeData;

  Future<void> switchTheme() async {
    prefs = await SharedPreferences.getInstance();
    if(_themeData == dark){
      _themeData = light;
      prefs.setBool("isDark", false);
    }else{
      _themeData = dark;
      prefs.setBool("isDark", true);
    }
    notifyListeners();
  }
}