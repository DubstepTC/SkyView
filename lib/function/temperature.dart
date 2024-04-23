import 'dart:io';
import 'package:SkyView/Appconstants/constants.dart';

class Temperaturetranslation {
    
    String temp = AppConstants.temperature;
    Future updateList() async {
    if (AppConstants.temperature == "°C" && temp != AppConstants.temperature){  

      for (int i = 0; i < AppConstants.weather.length; i++){
        int t = AppConstants.weather[i]['temperature'];

        t = ((t - 32) / 1.8).round();

        AppConstants.weather[i]['temperature'] = t;
      }
      
      for (int i = 0; i < AppConstants.data.length; i++){
        int t_max = AppConstants.data[i]["temperature_max"];
        int t_min = AppConstants.data[i]["temperature_min"];

        t_max = ((t_max - 32) / 1.8).round();
        t_min = ((t_min - 32) / 1.8).round();

        AppConstants.data[i]["temperature_max"] = t_max;
        AppConstants.data[i]["temperature_min"] = t_min;
      }
    
    }
    else if (AppConstants.temperature == "°F" && temp != AppConstants.temperature ) { 

      for (int i = 0; i < AppConstants.weather.length; i++){
        int t = AppConstants.weather[i]['temperature'];

        t = (t * 1.8 + 32).round();

        AppConstants.weather[i]['temperature'] = t;
      }

      for (int i = 0; i < AppConstants.data.length; i++){
        int t_max = AppConstants.data[i]["temperature_max"];
        int t_min = AppConstants.data[i]["temperature_min"];

        t_max = (t_max * 1.8 + 32).round();
        t_min = (t_min * 1.8 + 32).round();

        AppConstants.data[i]["temperature_max"] = t_max;
        AppConstants.data[i]["temperature_min"] = t_min;
      }
    }
  }
}