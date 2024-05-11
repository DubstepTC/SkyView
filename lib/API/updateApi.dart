import 'dart:convert';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:http/http.dart' as http;

class Updateapi {
  final String apiKey = '52055ecf549b4497813111413242104';
  final String baseApiUrl = 'http://api.weatherapi.com/v1/current.json';
  List<Map<String, dynamic>> cities = [];

  Map<String, String> weatherStatusTranslations = AppConstants.weatherStatusTranslations;

  Future getWeather(String city) async {
    var response = await http.get(Uri.parse('$baseApiUrl?key=$apiKey&q=$city&lang=ru'));
    
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      // Декодируем данные в UTF-8
      String weatherStatus = data['current']['condition']['text'];
      String translatedWeatherStatus = weatherStatusTranslations[weatherStatus] ?? weatherStatus;

      //Температура
      double temp = data['current']['temp_c'];
      int t;
      int t_feelslike_c = data['current']['feelslike_c'].round();

      if (AppConstants.temperature == "°C") {
        t = temp.round();
        t_feelslike_c = t_feelslike_c.round();
      }
      else {
        t = (temp * 1.8 + 32).round();
        t_feelslike_c = (t_feelslike_c * 1.8 + 32).round();
      }

      //Скорость ветра

      String wind;

      if (AppConstants.windSpeed == "Километры в час") {
        wind = (data['current']['wind_kph']).toString();
      }
      else if (AppConstants.windSpeed == "Метры в секунду") {
        double s = data['current']['wind_kph'];
        wind = ((s * 1000 / 3600 * 10).round() / 10).toString();
      }
      else if (AppConstants.windSpeed == "Мили в час") {
        wind = (data['current']['wind_mph']).toString();
      }
      else if (AppConstants.windSpeed == "Шкала Бофорта") {
        int s = int.parse(data['current']['wind_kph']);
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
        double s = data['current']['wind_kph'];
        wind = ((s * 0.539957 * 10).round() / 10).toString();
      }

      cities.add({
        'city': data['location']['name'],
        'country': data['location']['country'],
        'temperature': t,
        'speed': data['current']['wind_kph'],
        'weather_status': translatedWeatherStatus,
        'pressure_mb': data['current']['pressure_mb'],
        'wind_kph': wind,
        'humidity': data['current']['humidity'],
        'uv': data['current']['uv'],
        'feelslike_c': t_feelslike_c,
      });
      updateWeatherForCities(cities);
      cities = [];
    } else {
      print("Ошибка при получении данных о погоде");
    }
  }

  Future<void> updateWeatherForCities(List<Map<String, dynamic>> cityWeatherData) async {
  for (var cityData in cityWeatherData) {
    AppConstants.weather.add(cityData);
  }
}
}