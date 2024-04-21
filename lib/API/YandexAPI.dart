import 'dart:convert';
import 'package:http/http.dart' as http;

class  WeatherInfoWidget{
  String apiKey = "0c7c4ad9-c819-4d0c-8fde-ddac3c7cb5e4";

  Future<void> getWeatherInfo(String city) async {

    String url = 'https://api.weather.yandex.ru/v2/forecast?lat=52.37125&lon=4.89388';
    var response = await http.get(Uri.parse(url), headers: {
      'X-Yandex-API-Key': apiKey,
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      
      //String cityName = data['geo_object']['locality']['name'];
      //String countryName = data['geo_object']['locality']['country']['name'];
      //int temperature = data['fact']['temp'];
      //String weatherCondition = data['fact']['condition'];

      //print('Город: $cityName, Страна: $countryName, Температура: $temperature°C, Статус погоды: $weatherCondition');
    } else {
      print('Ошибка получения данных о погоде');
    }
  }
}