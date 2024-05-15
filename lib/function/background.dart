import 'package:flutter/material.dart';

class BackgroundHelper {
  String buildWeatherImage(String weather) {
    switch (weather) {
      case 'Ясно':
        return "assets/images/background_clear.jpg";
      case 'Солнечно':
        return "assets/images/background_clear.jpg";
      case 'Дождь':
      case 'Небольшой дождь':
        return "assets/images/background_rain.jpg";
      case 'Снег':
        return "assets/images/background_snowfall.jpg";
      case 'Переменная облачность':
      case 'Облачно':
       return "assets/images/background_cloudy.jpg";
      case 'Гроза':
        return "assets/images/background_thunderstorm.jpg";
      default:
        return "assets/images/background_night.jpg";
    }
  }
}