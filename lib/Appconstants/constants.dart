//Общие переменные
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  static String url = "";
  static List<String> cities = ['Москва', 'Тверь'];
  static Color nightColor = const Color.fromRGBO(194, 184, 255, 1.0); 
  static Color sunColor = const Color.fromRGBO(245, 255, 184, 1.0); // Пример списка городов 


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
  }

  // Сохранение значений в SharedPreferences
  static Future<void> savePreferences() async {
    await _preferences.setString('temperature', temperature);
    await _preferences.setString('windSpeeed', windSpeeed);
    await _preferences.setString('pressure', pressure);
  }
}