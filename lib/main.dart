import 'package:SkyView/API/futureApi.dart';
import 'package:SkyView/API/updateApi.dart';
import 'package:flutter/material.dart';
import 'package:SkyView/pages/main_page.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:intl/intl.dart';  

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConstants.initialize();
  
  FutureApi future = FutureApi();
  Updateapi weather = Updateapi();

  // Создаем список Future для запуска функций асинхронно
  List<Future> futures = [];
  List<Map<String, dynamic>> days = forecastForFiveDays();

  for (var cityMap in AppConstants.cityCountryMap) {
    String city = cityMap["city"];
    var weatherMain = await weather.getWeather(city);
    if (weatherMain != null) {
        futures.add(weatherMain);
    }
  }

  for (var day in days) {
    String city = day["city"];
    String date = day["date"];
    var weather = await future.getWeather(city, date);
    if (weather != null) {
        futures.add(weather);
    }
  }

  // Дожидаемся завершения всех асинхронных операций
  await Future.wait(futures);

  for(int i = 0; i < AppConstants.cityCountryMap.length; i++){
    if (AppConstants.cityCountryMap[i]["city"] == AppConstants.weather[i]["city"]){
      AppConstants.cityCountryMap[i]["temperature"] = AppConstants.weather[i]["temperature"];
      AppConstants.cityCountryMap[i]["weather_status"] = AppConstants.weather[i]["weather_status"];
    }
  }

  runApp(const MainApp());
}

List<Map<String, dynamic>> forecastForFiveDays() {
  List<Map<String, dynamic>> days = [];
  DateTime today = DateTime.now();

  for (var cityMap in AppConstants.cityCountryMap) {
    String city = cityMap["city"];
    for (int i = 0; i <= 4; i++) {
      DateTime nextDate = today.add(Duration(days: i));
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(nextDate);
      Map<String, dynamic> future = {
        "city": city,
        "date": formattedDate
      };
      days.add(future);
    }
  }
  return days;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PopScope(
        child: MainScreen(currentIndex: 0,),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}