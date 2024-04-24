import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  static Map<String, String> weatherStatusTranslations = {
    'Clear': 'Ясно',
    'Partly cloudy': 'Переменная облачность',
    'Cloudy': 'Облачно',
    'Sunny': 'Солнечно',
    'Patchy rain nearby': 'Мелкий дождь',
    // Добавьте другие переводы состояний погоды по мере необходимости
  };

  //Запрос
  static List<Map<String, dynamic>> cityWeather = [];
  //Список городов пользователя
  static List<Map<String, dynamic>> cityCountryMap = [
    {"city": "Москва", "country": "Россия", "temperature": 8, "weather_status": "Ясно"},
    {"city": "Тверь", "country": "Россия", "temperature": 12, "weather_status": "Дождь"}
  ];
  //Список обновляемой информации
  static List<Map<String, dynamic>> weather = [];
  //Список прогнозов на 5 дней 
  static List<Map<String, dynamic>> data = [];

  static Color nightColor = const Color.fromRGBO(194, 184, 255, 1.0); 
  static Color sunColor = const Color.fromRGBO(245, 255, 184, 1.0);
  static Color backColor = const Color.fromRGBO(39, 64, 87, 0.35);

  static String temperature = "";
  static String windSpeed = ""; // Исправлено название переменной
  static String pressure = "";

  static late SharedPreferences _preferences;

  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    temperature = _preferences.getString('temperature') ?? "°C";
    windSpeed = _preferences.getString('windSpeed') ?? "Километры в час"; // Исправлено название переменной
    pressure = _preferences.getString('pressure') ?? "Миллиметр ртутного столба (мм рт. ст)";

    String? cityCountryMapAsString = _preferences.getString('cityCountryMap');
    if (cityCountryMapAsString != null) {
      List<dynamic>? decodedList = json.decode(cityCountryMapAsString);

      if (decodedList != null && decodedList is List) {
        cityCountryMap = decodedList.cast<Map<String, dynamic>>();
      }
    }
  }

  static Future<void> savePreferences() async {
    await _preferences.setString('temperature', temperature);
    await _preferences.setString('windSpeed', windSpeed); // Исправлено название переменной
    await _preferences.setString('pressure', pressure);

    String cityCountryMapAsString = jsonEncode(cityCountryMap);
    await _preferences.setString('cityCountryMap', cityCountryMapAsString);
  }
}