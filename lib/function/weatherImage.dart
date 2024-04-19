import 'package:flutter/material.dart';

class WeatherHelper {
  Widget buildWeatherImage(String weather) {
    switch (weather) {
      case 'Ясно':
        return Image.asset("assets/signs/month.png");
      case 'Дождь':
        return Image.asset("assets/signs/rain.png");
      //case 'Снег':
      //  return Image.asset("assets/signs/snow.png");
      //case 'Облачно':
      // return Image.asset("assets/signs/cloudy.png");
      //case 'Гроза':
      //  return Image.asset("assets/signs/storm.png");
      default:
        return Image.asset("assets/signs/month.png");
    }
  }
}