import 'dart:io';
import 'package:SkyView/Appconstants/constants.dart';

class Speedtranslation {
  
  String wind = AppConstants.windSpeed;
  Future updateList() async{
    for (int i = 0; i < AppConstants.weather.length; i ++){

      double speed = AppConstants.weather[i]['speed'];

        if (AppConstants.windSpeed == "Километры в час" && wind != AppConstants.windSpeed) {
          AppConstants.weather[i]["wind_kph"] = speed;
        }
        else if (AppConstants.windSpeed == "Метры в секунду" && wind != AppConstants.windSpeed) {
          AppConstants.weather[i]["wind_kph"] = ((speed * 1000 / 3600 * 10).round() / 10).toString();
        }
        else if (AppConstants.windSpeed == "Мили в час" && wind != AppConstants.windSpeed) {
          AppConstants.weather[i]["wind_kph"] = ((speed * 0.621371 * 10).round() / 10).toString();
        }
        else if (AppConstants.windSpeed == "Шкала Бофорта" && wind != AppConstants.windSpeed) {
          int s = int.parse(speed.round().toString());
          s = (s * 0.539957).round();
          if (s < 1) {
            AppConstants.weather[i]["wind_kph"] = "0";
          } else if (s >= 1 && s <= 3) {
            AppConstants.weather[i]["wind_kph"] = "1";
          } else if (s >= 4 && s <= 6) {
            AppConstants.weather[i]["wind_kph"] = "2";
          } else if (s >= 7 && s <= 10) {
            AppConstants.weather[i]["wind_kph"] = "3";
          } else if (s >= 11 && s <= 15) {
            AppConstants.weather[i]["wind_kph"] = "4";
          } else if (s >= 16 && s <= 20) {
            AppConstants.weather[i]["wind_kph"] = "5";
          } else if (s >= 21 && s <= 26) {
            AppConstants.weather[i]["wind_kph"] = "6";
          } else if (s >= 27 && s <= 33) {
            AppConstants.weather[i]["wind_kph"] = "7";
          } else if (s >= 34 && s <= 40) {
            AppConstants.weather[i]["wind_kph"] = "8";
          } else if (s >= 41 && s <= 47) {
            AppConstants.weather[i]["wind_kph"] = "9";
          } else if (s >= 48 && s <= 55) {
            AppConstants.weather[i]["wind_kph"] = "10";
          } else {
            AppConstants.weather[i]["wind_kph"] = "11";
          }
        }
      else if (AppConstants.windSpeed == "Узлы" && wind != AppConstants.windSpeed){
        AppConstants.weather[i]["wind_kph"] = ((speed * 0.539957 * 10).round() / 10).toString();
      }
      else {
      }
    } 
  }
}