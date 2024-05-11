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
    'Light rain': 'Небольшой дождь',
    // Добавьте другие переводы состояний погоды по мере необходимости
  };
  //Популярные города 
  static List<String> popularCities = [
    'Москва', 'Нью-Йорк', 'Токио', 'Лондон', 'Пекин', 
    'Париж', 'Берлин', 'Сеул', 'Дубай', 'Дели', 
    'Шанхай', 'Сан-Паулу', 'Мехико', 'Каир', 'Истанбул',
  ];
  //Список температур
  static List<double> tempList = [
    20.1, 21.2, 22.3, 23.4, 24.5, 25.6, 26.7, 27.8, 28.9,
    29.0, 30.1, 31.2, 32.3, 33.4, 34.5, 35.6, 36.7, 37.8,
    38.9, 39.0, 40.1, 41.2, 42.3, 43.4,
  ];
  //Запрос
  static List<Map<String, dynamic>> cityWeather = [];
  //Список городов пользователя
  static List<Map<String, dynamic>> cityCountryMap = [];
  //Список обновляемой информации
  static List<Map<String, dynamic>> weather = [];
  //Список прогнозов на 5 дней 
  static List<Map<String, dynamic>> data = [];
  //Восход/закат 
  static List<Map<String, dynamic>> sunrise = [];
  //Погода на 24 часа 
  static List<Map<String, dynamic>> hours = [];

  static Color nightColor = const Color.fromRGBO(194, 184, 255, 1.0); 
  static Color sunColor = const Color.fromRGBO(245, 255, 184, 1.0);
  static Color backColor = const Color.fromRGBO(39, 64, 87, 0.35);

  static String temperature = "";
  static String windSpeed = ""; // Исправлено название переменной
  static String pressure = "";

  static String welcome = "false";

  static late SharedPreferences _preferences;

  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    temperature = _preferences.getString('temperature') ?? "°C";
    windSpeed = _preferences.getString('windSpeed') ?? "Километры в час"; // Исправлено название переменной
    pressure = _preferences.getString('pressure') ?? "Миллиметр ртутного столба (мм рт. ст)";
    welcome = _preferences.getString("welcome")?? "false";

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
    await _preferences.setString('welcome', welcome);

    String cityCountryMapAsString = jsonEncode(cityCountryMap);
    await _preferences.setString('cityCountryMap', cityCountryMapAsString);
  }
}