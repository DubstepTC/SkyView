import 'dart:convert';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:http/http.dart' as http;

class Updateapi {
  final String apiKey = '52055ecf549b4497813111413242104';
  final String baseApiUrl = 'http://api.weatherapi.com/v1/current.json';
  List<Map<String, dynamic>> cities = [];

  Map<String, String> weatherStatusTranslations = {
    'Clear': 'Ясно',
    'Partly cloudy': 'Переменная облачность',
    'Cloudy': 'Облачно',
    'Sunny': 'Солнечно',   
    'Patchy rain nearby': 'Мелкий дождь',
    // Добавьте другие переводы состояний погоды по мере необходимости
  };

  Future getWeather(String city) async {
    var response = await http.get(Uri.parse('$baseApiUrl?key=$apiKey&q=$city'));
    
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes)); // Декодируем данные в UTF-8
      String weatherStatus = data['current']['condition']['text'];
      String translatedWeatherStatus = weatherStatusTranslations[weatherStatus] ?? weatherStatus;

      //Температура
      double temp = data['current']['temp_c'];
      int t;

      if (AppConstants.temperature == "°C") {
        t = temp.round();
      }
      else {
        t = (temp * 1.8 + 32).round();
      }

      //Скорость ветра

      String wind;

      if (AppConstants.windSpeed == "Километры в час") {
        wind = (data['current']['wind_kph']).toString();
      }
      else if (AppConstants.windSpeed == "Метры в секунду") {
        double s = data['current']['wind_kph'];
        wind = ((s * 1000 / 3600).round() / 100).toString();
      }
      else if (AppConstants.windSpeed == "Мили в час") {
        wind = (data['current']['wind_mph']).toString();
      }
      else if (AppConstants.windSpeed == "Шкала Бофорта") {
        double s = data['current']['wind_kph'];
        s = (s / 1.852 * 100).round() / 100;
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
        wind = ((s / 1.852).round()).toString();
      }

      cities.add({
        'city': data['location']['name'],
        'country': data['location']['country'],
        'temperature': t,
        'weather_status': translatedWeatherStatus,
        'pressure_mb': data['current']['pressure_mb'],
        'wind_kph': wind,
        'humidity': data['current']['humidity'],
        'uv': data['current']['uv'],
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