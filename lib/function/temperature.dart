import 'dart:io';
import 'package:SkyView/Appconstants/constants.dart';

class Temperaturetranslation {
    
    String temp = AppConstants.temperature;
    Future updateList() async {
    if (AppConstants.temperature == "°C" && temp != AppConstants.temperature){  
      //Главная страница
      for (int i = 0; i < AppConstants.weather.length; i++){
        int t = AppConstants.weather[i]['temperature'];

        t = ((t - 32) / 1.8).round();

        AppConstants.weather[i]['temperature'] = t;
        AppConstants.weather[i]["feelslike_c"] = ((AppConstants.weather[i]["feelslike_c"] - 32) / 1.8).round();
      }
      
      for (int i = 0; i < AppConstants.data.length; i++){
        int t_max = AppConstants.data[i]["temperature_max"];
        int t_min = AppConstants.data[i]["temperature_min"];

        t_max = ((t_max - 32) / 1.8).round();
        t_min = ((t_min - 32) / 1.8).round();

        AppConstants.data[i]["temperature_max"] = t_max;
        AppConstants.data[i]["temperature_min"] = t_min;
      }

      //Список городов
      for (int i = 0; i < AppConstants.cityCountryMap.length; i++){
         
        int tem = AppConstants.cityCountryMap[i]['temperature'];

        tem = ((tem - 32) / 1.8).round();

        AppConstants.cityCountryMap[i]['temperature'] = tem;
      }
    
    }
    else if (AppConstants.temperature == "°F" && temp != AppConstants.temperature ) { 
      //Главная страница
      for (int i = 0; i < AppConstants.weather.length; i++){
        int t = AppConstants.weather[i]['temperature'];

        t = (t * 1.8 + 32).round();

        AppConstants.weather[i]['temperature'] = t;
        AppConstants.weather[i]["feelslike_c"] = (AppConstants.weather[i]["feelslike_c"] * 1.8 + 32).round();
      }

      for (int i = 0; i < AppConstants.data.length; i++){
        int t_max = AppConstants.data[i]["temperature_max"];
        int t_min = AppConstants.data[i]["temperature_min"];

        t_max = (t_max * 1.8 + 32).round();
        t_min = (t_min * 1.8 + 32).round();

        AppConstants.data[i]["temperature_max"] = t_max;
        AppConstants.data[i]["temperature_min"] = t_min;
      }

      //Список городов

      for (int i = 0; i < AppConstants.cityCountryMap.length; i++){
        int tem = AppConstants.cityCountryMap[i]['temperature'];

        tem = (tem * 1.8 + 32).round();

        AppConstants.cityCountryMap[i]['temperature'] = tem;
      }
    }
  }
}