import 'dart:convert';
import 'package:http/http.dart' as http;

class CityDataProvider {
  Future<List<Map<String, String>>> getCities() async {
    final url = Uri.parse(
        'http://api.geonames.org/citiesJSON?north=90&south=-90&east=180&west=-180&lang=en&maxRows=10000&username=dubi');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData.containsKey('geonames') && jsonData['geonames'] is List) {
          List<dynamic> cityData = jsonData['geonames'];
          List<Map<String, String>> cityList = [];

          for (var city in cityData) {
            cityList.add({
              'city': city['name'],
              'country': city['countryName'],
            });
          }

          return cityList;
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Failed to load city data: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load city data: $e');
    }
  }
}