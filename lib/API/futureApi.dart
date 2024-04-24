import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';

class FutureApi {
  final String apiKey = '52055ecf549b4497813111413242104';
  final String baseApiUrl = 'http://api.weatherapi.com/v1/forecast.json';
  List<Map<String, dynamic>> cities = [];

  Map<String, String> weatherStatusTranslations = AppConstants.weatherStatusTranslations;

  Future getWeather(String city, String date) async {
    var response = await http.get(Uri.parse('$baseApiUrl?key=$apiKey&q=$city&date=$date'));
    
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes)); // Декодируем данные в UTF-8
      String weatherStatus = data['current']['condition']['text'];
      String translatedWeatherStatus = weatherStatusTranslations[weatherStatus] ?? weatherStatus;

      //Температура и дата
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      List<dynamic> forecast = data["forecast"]["forecastday"];
      String date = forecast[0]["date"];
      double temp_min = forecast[0]["day"]["mintemp_c"];
      double temp_max = forecast[0]["day"]["maxtemp_c"];;
      int t_min;
      int t_max;

      if (AppConstants.temperature == "°C") {
        t_min = temp_min.round();
        t_max = temp_max.round();
      }
      else {
        t_min = (temp_min * 1.8 + 32).round();
        t_max = (temp_max * 1.8 + 32).round();
      }

      // ignore: await_only_futures
      if (date == formatter.format(await DateTime.now())){
        date = "Сегодня";
      }
      else{
        DateTime nameday = DateTime.parse(date);
        await initializeDateFormatting('ru', null).then((_) {
          String dayOfWeek  = DateFormat.EEEE('ru').format(nameday);
          date = dayOfWeek[0].toUpperCase() + dayOfWeek.substring(1);
        });
      }
      
      cities.add({
        'data': date,
        'status': translatedWeatherStatus,
        'temperature_min': t_min,
        'temperature_max': t_max,
      });
      updateWeatherForCities(cities);
      cities = [];
    } else {
      print("Ошибка при получении данных о погоде");
    }
  }

  Future<void> updateWeatherForCities(List<Map<String, dynamic>> cityWeatherData) async {
  for (var cityData in cityWeatherData) {
    AppConstants.data.add(cityData);
  }
}
}