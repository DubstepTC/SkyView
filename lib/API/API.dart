import 'dart:convert';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

class API {
  Future<List<Map<String, dynamic>>> searchCitiesStartingWith(String prefix) async {
    final String apiKey = '73f14a975f425a2e18cfce1792b04aef';
    final String apiUrl = 'http://api.openweathermap.org/data/2.5/find?q=$prefix&lang=ru&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> dataList = json.decode(response.body)['list'];
        List<Map<String, dynamic>> cities = [];

        for (var data in dataList) {
          String cityName = data['name'];
          String cityNameRU = await translateText(cityName, "b1gu4kgh5mqp0p7kvnil");

          String countryCode = data['sys']['country'];
          String countryName = await getCountryName(countryCode);
          String countryNameRU = await translateText(countryName, "b1gu4kgh5mqp0p7kvnil"); // Получение полного названия страны

          double temperature = data['main']['temp'];
          String weatherStatus = data['weather'][0]['description'];

          int t;
          if (AppConstants.temperature == "°C") {
            t = (temperature - 273.15).round();
          } else {
            t = ((temperature - 273.15) * 1.8 + 32).round();
          } // Округление температуры

          cities.add({
            'city': cityNameRU,
            'country': countryNameRU,
            'temperature': t,
            'weather_status': weatherStatus,
          });
        }

        return cities;
      } else {
        print('Ошибка: ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      print('Ошибка при выполнении запроса: $e');
      return [];
    }
  }

  Future<String> getCountryName(String countryCode) async {
    final String apiUrl = 'https://restcountries.com/v3.1/alpha/$countryCode';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return json.decode(response.body)[0]['name']['common'];
      } else {
        print('Ошибка: ${response.reasonPhrase}');
        return 'Unknown';
      }
    } catch (e) {
      print('Ошибка при выполнении запроса к REST Countries: $e');
      return 'Unknown';
    }
  }

  Future<String> translateText(String text, String apiKey) async {
    final String baseUrl = 'https://translate.yandex.net/api/v1.5/tr.json/translate';
    final String lang = 'en-ru'; // Задаем язык перевода, например, с английского на русский

    Uri url = Uri.parse('$baseUrl?key=$apiKey&lang=$lang&text=${Uri.encodeComponent(text)}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      if (data['code'] == 200) {
        return data['text'][0];
      } else {
        throw Exception('Произошла ошибка при переводе текста');
      }
    } else {
      throw Exception('Произошла ошибка при обращении к серверу');
    }
  }
}