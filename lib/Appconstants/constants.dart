//Общие переменные
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  static String url = "";
  
  static Map<String, String> cityCountryMap = {
    'Москва': 'Россия',
    'Тверь': 'Россия',
    'London': 'vel',
  };

  static Color nightColor = const Color.fromRGBO(194, 184, 255, 1.0); 
  static Color sunColor = const Color.fromRGBO(245, 255, 184, 1.0);
  static Color backColor = const Color.fromRGBO(39, 64, 87, 0.35);


  //Параметры настроек
  static String temperature = "";
  static String windSpeeed = "";
  static String pressure = "";

  // Инициализация SharedPreferences
  static late SharedPreferences _preferences;

  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    // Загрузка значений из SharedPreferences
    temperature = _preferences.getString('temperature') ?? "°C";
    windSpeeed = _preferences.getString('windSpeeed') ?? "Километры в час";
    pressure = _preferences.getString('pressure') ?? "Миллиметр ртутного столба (мм рт. ст)"; 

    // Получение строки из SharedPreferences
    String? cityCountryMapAsString = _preferences.getString('cityCountryMap');
    // Проверка на наличие данных в SharedPreferences
    if (cityCountryMapAsString != null) {
      Map<String, dynamic> decodedMap = json.decode(cityCountryMapAsString);
      cityCountryMap = decodedMap.map((key, value) => MapEntry(key, value.toString()));
    }
  }

  // Сохранение значений в SharedPreferences
  static Future<void> savePreferences() async {
    await _preferences.setString('temperature', temperature);
    await _preferences.setString('windSpeeed', windSpeeed);
    await _preferences.setString('pressure', pressure);

    // Преобразование Map<String, String> в строку
    String cityCountryMapAsString = jsonEncode(cityCountryMap);
    // Сохранение строки в SharedPreferences
    await _preferences.setString('cityCountryMap', cityCountryMapAsString);
  }

  
}