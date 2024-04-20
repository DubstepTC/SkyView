import 'dart:convert';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:http/http.dart' as http;

class CityDataProvider {
  Future<List<Map<String, String>>> getCities(String? cityName) async {
    final url = Uri.parse(
        'http://api.geonames.org/searchJSON?name=$cityName&north=90&south=-90&east=180&west=-180&lang=en&maxRows=1000&username=dubi');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData.containsKey('geonames')) {
          if (jsonData['geonames'] is List) {
            List<dynamic> cityData = jsonData['geonames'];

            for (var city in cityData) {
              if (city is Map<String, dynamic> &&
                  city.containsKey('name') &&
                  city.containsKey('countryName') &&
                  city.containsKey('population')) {
                
                // Удаление дубликатов
                if (!AppConstants.citySearch.any((element) => element['city'] == city['name'] && element['country'] == city['countryName'])) {
                  // Добавление основных городов в список
                  if (city['population'] > 1000) {
                    AppConstants.citySearch.add({
                      'city': city['name'],
                      'country': city['countryName'],
                    });
                  }
                }
              } else {
                throw Exception('Invalid city data format');
              }
            }
            
            // Сортировка списка городов по названию
            AppConstants.citySearch.sort((a, b) => a['city']!.compareTo(b['city']!));
            return AppConstants.citySearch;
          } else {
            throw Exception('Invalid data format: "geonames" field is not a List');
          }
        } else {
          throw Exception('Invalid data format: "geonames" field is missing');
        }
      } else {
        throw Exception('Failed to load city data: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load city data: $e');
    }
  }
}
