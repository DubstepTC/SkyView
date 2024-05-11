import 'dart:convert';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:http/http.dart' as http;

class SunriseApi {
  final String apiKey = '52055ecf549b4497813111413242104';
  final String baseApiUrl = 'http://api.weatherapi.com/v1/astronomy.json';
  List<Map<String, dynamic>> cities = [];

  Map<String, String> weatherStatusTranslations = AppConstants.weatherStatusTranslations;

  Future getSunrise(String city) async {
    var response = await http.get(Uri.parse('$baseApiUrl?key=$apiKey&q=$city&lang=ru'));
    
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      String convertTimeToFlutterFormat(String time) {
        if (time.contains('AM')) {
          return time.replaceAll('AM', '');
        } else if (time.contains('PM')) {
          List<String> timeParts = time.split(':');
          int hours = int.parse(timeParts[0]);
          if (hours < 12) {
            hours += 12;
          }
          return '$hours:${timeParts[1].replaceAll(' PM', '')}';
        }
        return time;
      }
      
      cities.add({
        'sunrise': convertTimeToFlutterFormat(data['astronomy']["astro"]['sunrise']),
        'sunset': convertTimeToFlutterFormat(data['astronomy']["astro"]['sunset']),
      });
      AppConstants.sunrise = [];
      updateWeatherForCities(cities);
      cities = [];
    } else {
      print("Ошибка при получении данных о погоде");
    }
  }

  Future<void> updateWeatherForCities(List<Map<String, dynamic>> cityWeatherData) async {
  for (var cityData in cityWeatherData) {
    AppConstants.sunrise.add(cityData);
  }
}
}