import 'package:flutter/material.dart';

class BackgroundHelper {
  Widget buildWeatherImage(String weather) {
    switch (weather) {
      case 'Ясно':
        return Image.asset("assets/signs/clear.png");
      case 'Солнечно':
        return Image.asset("assets/signs/clear.png");
      case 'Дождь':
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