import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';

class HoursApi {
  final String apiKey = '52055ecf549b4497813111413242104';
  final String baseApiUrl = 'http://api.weatherapi.com/v1/forecast.json';
  List<Map<String, dynamic>> cities = [];

  Map<String, String> weatherStatusTranslations = AppConstants.weatherStatusTranslations;

  Future getHours(String city, String date, String hour) async {
    var response = await http.get(Uri.parse('$baseApiUrl?key=$apiKey&q=$city&date=$date&hour=$hour&lang=ru'));
    
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List<dynamic> forecast = data["forecast"]["forecastday"];
      String weatherStatus = forecast[0]["hour"][0]['condition']['text'];
      String translatedWeatherStatus = weatherStatusTranslations[weatherStatus] ?? weatherStatus;

      //Температура
      double temperature = forecast[0]["hour"][0]["temp_c"];
      int temp;
      int wind_speed = 1;

      if (AppConstants.temperature == "°C") {
        temp = temperature.round();
      }
      else {
        temp = (temperature * 1.8 + 32).round();
      }

      //Скорость ветра

      String wind;

      if (AppConstants.windSpeed == "Километры в час") {
        wind = (forecast[0]["hour"][0]["wind_kph"]).toString();
      }
      else if (AppConstants.windSpeed == "Метры в секунду") {
        double s = forecast[0]["hour"][0]["wind_kph"];
        wind = ((s * 1000 / 3600 * 10).round() / 10).toString();
      }
      else if (AppConstants.windSpeed == "Мили в час") {
        wind = (forecast[0]["hour"][0]["wind_mph"]).toString();
      }
      else if (AppConstants.windSpeed == "Шкала Бофорта") {
        int s = int.parse(forecast[0]["hour"][0]["wind_kph"].round().toString());
        s = (s * 0.539957).round();
        if (s < 1) {
          wind = "0";
        } else if (s >= 1 && s <= 3) {
          wind = "1";
        } else if (s >= 4 && s <= 6) {
          wind = "2";
        } else if (s >= 7 && s <= 10) {
          wind = "3";
        } else if (s >= 11 && s <= 15) {
          wind = "4";
        } else if (s >= 16 && s <= 20) {
          wind = "5";
        } else if (s >= 21 && s <= 26) {
          wind = "6";
        } else if (s >= 27 && s <= 33) {
          wind = "7";
        } else if (s >= 34 && s <= 40) {
          wind = "8";
        } else if (s >= 41 && s <= 47) {
          wind = "9";
        } else if (s >= 48 && s <= 55) {
          wind = "10";
        } else {
          wind = "11";
        }
      }
      else {
        double s = forecast[0]["hour"][0]["wind_kph"];
        wind = ((s * 0.539957 * 10).round() / 10).toString();
      }

      //Осадки %
      String chance;
      if (forecast[0]["day"]["daily_chance_of_rain"] == 0 && forecast[0]["day"]["daily_chance_of_snow"] != 0){
        chance = forecast[0]["day"]["daily_chance_of_snow"].toString();
      }
      else if (forecast[0]["day"]["daily_chance_of_rain"] != 0 && forecast[0]["day"]["daily_chance_of_snow"] == 0) {
        chance = forecast[0]["day"]["daily_chance_of_rain"].toString();
      }
      else {
        chance = "0";
      }

      cities.add({
        'city': city,
        'data': forecast[0]["hour"][0]["time"],
        'status': translatedWeatherStatus,
        'temperature': temp,
        'wind_speed': wind,
        'chance': chance,
      });
      updateWeatherForCities(cities);
      cities = [];
    } else {
      print("Ошибка при получении данных о погоде");
    }
  }

  Future<void> updateWeatherForCities(List<Map<String, dynamic>> cityWeatherData) async {
  for (var cityData in cityWeatherData) {
    AppConstants.hours.add(cityData);
  }
}
}