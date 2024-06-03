import 'package:intl/intl.dart';

class BackgroundHelper {
  String buildWeatherImage(String weather) {

    var now = DateTime.now();
    var formatter = DateFormat('HH');
    var formattedTime = formatter.format(now);
    int currentTime = int.parse(formattedTime);
  

    switch (weather) {
      case 'Ясно':
      case 'Солнечно':
         if (currentTime >= 4 && currentTime <= 17) {
          return "assets/images/background_clear.jpg";
        }
        else {
          return "assets/images/background_night.jpg";
        }
      case 'Дождь':
      case 'Мелкий дождь':
      case 'Небольшой дождь':
      case 'Местами дождь':
      case 'Местами дождь со снегом':
      case 'Местами замерзающая морось':
      case 'Местами слабая морось':
      case 'Слабая морось':
      case 'Замерзающая морось':
      case 'Сильная замерзающая морось':
      case 'Местами небольшой дождь':
      case 'Временами умеренный дождь':
      case 'Умеренный дождь':
      case 'Временами сильный дождь':
      case 'Сильный дождь':
      case 'Небольшой ледяной дождь':
      case 'Сильные ливни':
      case 'Небольшой ливневый дождь':
      case 'Ледяной дождь':
        return "assets/images/background_rain.jpg";
      case 'Снег':
      case 'Местами снег':
      case 'Поземок':
      case 'Метель':
      case 'Местами небольшой снег':
      case 'Небольшой снег':
      case 'Местами умеренный снег':
      case 'Умеренный снег':
      case 'Местами сильный снег':
      case 'Сильный снег':
      case 'Умеренный или сильный снег':
        return "assets/images/background_snowfall.jpg";
      case 'Переменная облачность':
      case 'Облачно':
      case 'Пасмурно':
      case 'Дымка':
      case 'Туман':
      case 'Переохлажденный туман':
       return "assets/images/background_cloudy.jpg";
      case 'Гроза':
      case 'Местами грозы':
        return "assets/images/background_thunderstorm.jpg";
      default:
        return "assets/images/background_night.jpg";
    }
  }
}