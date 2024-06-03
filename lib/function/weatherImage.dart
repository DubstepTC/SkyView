import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherHelper {
  Widget buildWeatherImage(String weather) {

    var now = DateTime.now();
    var formatter = DateFormat('HH');
    var formattedTime = formatter.format(now);
    int currentTime = int.parse(formattedTime);
  
    switch (weather) {
      case 'Ясно':
      case 'Солнечно':
        if (currentTime >= 17) {
          return Image.asset("assets/signs/month.png");
        }
        else {
          return Image.asset("assets/signs/clear.png");
        }
      case 'Дождь':
      case 'Мелкий дождь':
      case 'Небольшой дождь':
      case 'Местами дождь':
      case 'Местами дождь со снегом':
      case 'Местами замерзающая морось':
      case 'Местами слабая морось':
      case 'Слабая морось':
      case 'Замерзающая морось':
      case 'Сильная замерзающая морось':
      case 'Местами небольшой дождь':
      case 'Временами умеренный дождь':
      case 'Умеренный дождь':
      case 'Временами сильный дождь':
      case 'Сильный дождь':
      case 'Небольшой ледяной дождь':
      case 'Сильные ливни':
      case 'Небольшой ливневый дождь':
      case 'Ледяной дождь':
        return Image.asset("assets/signs/rain.png");
      case 'Снег':
      case 'Местами снег':
      case 'Поземок':
      case 'Метель':
      case 'Местами небольшой снег':
      case 'Небольшой снег':
      case 'Местами умеренный снег':
      case 'Умеренный снег':
      case 'Местами сильный снег':
      case 'Сильный снег':
      case 'Умеренный или сильный снег':
        return Image.asset("assets/signs/snow.png");
      case 'Переменная облачность':
      case 'Облачно':
      case 'Пасмурно':
      case 'Дымка':
      case 'Туман':
      case 'Переохлажденный туман':
       return Image.asset("assets/signs/cloud.png");
      case 'Гроза':
      case 'Местами грозы':
        return Image.asset("assets/signs/thunderstorm.png");
      default:
        return Image.asset("assets/signs/month.png");
    }
  }
}