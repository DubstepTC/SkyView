import 'dart:convert';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen {
  final String apiKey = '52055ecf549b4497813111413242104';
  final String baseApiUrl = 'http://api.weatherapi.com/v1/current.json';
  List<Map<String, dynamic>> cities = [];

  Map<String, String> weatherStatusTranslations = {
    'Clear': 'Ясно',
    'Partly cloudy': 'Переменная облачность',
    'Cloudy': 'Облачно',
    'Sunny': 'Солнечно',
    // Добавьте другие переводы состояний погоды по мере необходимости
  };

  void getWeather(String city) async {
    var response = await http.get(Uri.parse('$baseApiUrl?key=$apiKey&q=$city'));
    
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes)); // Декодируем данные в UTF-8

      String weatherStatus = data['current']['condition']['text'];
      String translatedWeatherStatus = weatherStatusTranslations[weatherStatus] ?? weatherStatus;

      double temp = data['current']['temp_c'];
      int t;

      if (AppConstants.temperature == "°C") {
        t = temp.round();
      }
      else {
        t = (temp * 1.8 + 32).round();
      }

      cities.add({
        'city': data['location']['name'],
        'country': data['location']['country'],
        'temperature': t,
        'weather_status': translatedWeatherStatus,
      });
      AppConstants.cityWeather = cities;
      cities = [];
    } else {
      print("Ошибка при получении данных о погоде");
    }
  }
}