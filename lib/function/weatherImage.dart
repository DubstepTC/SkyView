import 'package:flutter/material.dart';

class WeatherHelper {
  Widget buildWeatherImage(String weather) {
    switch (weather) {
      case 'Ясно':
      case 'Солнечно':
        return Image.asset("assets/signs/clear.png");
      case 'Дождь':
      case 'Мелкий дождь':
      case 'Небольшой дождь':
        return Image.asset("assets/signs/rain.png");
      case 'Снег':
        return Image.asset("assets/signs/snow.png");
      case 'Переменная облачность':
      case 'Облачно':
       return Image.asset("assets/signs/cloud.png");
      case 'Гроза':
        return Image.asset("assets/signs/thundaerstorm.png");
      default:
        return Image.asset("assets/signs/month.png");
    }
  }
}