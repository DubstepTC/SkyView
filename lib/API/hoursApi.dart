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
      double temperature = data["current"]["temp_c"];
      int temp;
      int wind_speed = 1;

      if (AppConstants.temperature == "°C") {
        temp = temperature.round();
      }
      else {
        temp = (temperature * 1.8 + 32).round();
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
        'data': forecast[0]["hour"][0]["time"],
        'status': translatedWeatherStatus,
        'temperature': forecast[0]["hour"][0]["temp_c"],
        'wind_speed': forecast[0]["hour"][0]["wind_kph"],
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