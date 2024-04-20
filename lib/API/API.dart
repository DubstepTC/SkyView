import 'dart:convert';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:http/http.dart' as http;

class API {
  Future<Map<String, dynamic>> fetchWeatherForCityAndCountry(String city, String country) async {
    final String apiKey = '73f14a975f425a2e18cfce1792b04aef';
    final String apiUrl = 'http://api.openweathermap.org/data/2.5/weather?q=$city,$country&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String cityName = data['name'];
        String countryName = data['sys']['country'];
        double temperature = data['main']['temp'];
        String weatherStatus = data['weather'][0]['main'];

        int t;
        if (AppConstants.temperature == "°C") {
          t = (temperature - 273.15).round();
        }
        else {
          t = ((temperature - 273.15) * 1.8 + 32).round();
        }
        
        return {
          'city': cityName,
          'country': countryName,
          'temperature': t,
          'weather_status': weatherStatus,
        };
      } else {
        print('Ошибка: ${response.reasonPhrase}');
        return {};
      }
    } catch (e) {
      print('Ошибка при выполнении запроса: $e');
      return {};
    }
  }
}
