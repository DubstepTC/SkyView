import 'dart:convert';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:http/http.dart' as http;

class WeatherScreen {
  final String apiKey = '52055ecf549b4497813111413242104';
  final String baseApiUrl = 'http://api.weatherapi.com/v1/current.json';
  List<Map<String, dynamic>> cities = [];

  Map<String, String> weatherStatusTranslations = AppConstants.weatherStatusTranslations;

  Future getWeather(String city) async {
    var response = await http.get(Uri.parse('$baseApiUrl?key=$apiKey&q=$city&lang=ru'));
    
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes)); // Декодируем данные в UTF-8

      String weatherStatus = data['current']['condition']['text'];
      String translatedWeatherStatus = weatherStatusTranslations[weatherStatus] ?? weatherStatus;
      
      switch (translatedWeatherStatus) {
        case 'Умеренный или сильный ледяной дождь':
        case 'Умеренный или сильный переохлажденный дождь':
        case 'Умеренный или сильный ливневый дождь':
        case 'Слабый переохлажденный дождь':
          translatedWeatherStatus = 'Умеренный дождь';
            break;
        case 'Небольшой дождь со снегом':
        case 'Умеренный или сильный дождь со снегом':
        case 'Небольшой ливневый дождь со снегом':
        case 'Умеренные или сильные ливневые дожди со снегом':
          translatedWeatherStatus = 'Дождь со снегом';
          break;
        case 'В отдельных районах местами небольшой дождь с грозой':
        case 'В отдельных районах умеренный или сильный дождь с грозой':
        case 'В отдельных районах местами небольшой снег с грозой':
        case 'В отдельных районах умеренный или сильный снег с грозой':
          translatedWeatherStatus = 'Местами грозы';
          break;
        default:
          break;
      }

      double temp = data['current']['temp_c'];
      int t;

      if (AppConstants.temperature == "°C") {
        t = temp.round();
      }
      else {
        t = (temp * 1.8 + 32).round();
      }
      if (data['location']['name'] == "Архангельск"){
        data['location']['country'] = "Россия";
      }


      cities.add({
        'city': data['location']['name'],
        'country': data['location']['country'],
        'temperature': t,
        'weather_status': translatedWeatherStatus,
      });
      AppConstants.cityWeather = cities;
      cities = [];
    } else {
      print("Ошибка при получении данных о погоде");
    }
  }
}