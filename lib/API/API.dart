import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  Future<List<String>> fetchAllCities() async {
    final String apiKey = '73f14a975f425a2e18cfce1792b04aef'; // Ваш API ключ

    final String apiUrl = 'http://api.openweathermap.org/data/2.5/box/city?bbox=-180,-90,180,90,10&appid=$apiKey'; // Запрос для получения всех городов

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Если запрос успешен, распарсим JSON ответ
        List<dynamic> data = json.decode(response.body);
        List<String> cities = [];
        for (var cityData in data) {
          cities.add(cityData['name']);
        }
        return cities;
      } else {
        // Если запрос не удался, выведем сообщение об ошибке
        print('Ошибка: ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      // Если произошла ошибка при выполнении запроса, выведем сообщение об ошибке
      print('Ошибка при выполнении запроса: $e');
      return [];
    }
  }
}