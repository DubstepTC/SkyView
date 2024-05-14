import 'package:SkyView/API/futureApi.dart';
import 'package:SkyView/API/openApi.dart';
import 'package:SkyView/API/timeZoneName.dart';
import 'package:SkyView/API/updateApi.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/pages/main_page.dart';
import 'package:SkyView/pages/start/entry.dart';
import 'package:flutter/material.dart';
import 'package:SkyView/function/weatherImage.dart'; 
import 'package:intl/intl.dart';  

class StartCardCities extends StatefulWidget {
  final double width;
  final double height; 
  final String temperature;
  final String city;
  final String country;
  final String weather;

  const StartCardCities({super.key,required this.width, required this.height, required this.temperature, required this.city, required this.country , required this.weather});

  @override
    _StartCardCitiesState createState() => _StartCardCitiesState();
  }

  class _StartCardCitiesState extends State<StartCardCities> {

  Future add(cityData) async {
    bool cityExists = AppConstants.cityCountryMap.any((element) =>
        element['city'].toLowerCase() == cityData['city'].toLowerCase());

    if (!cityExists) {
      AppConstants.cityCountryMap.add(cityData);
    } else {
      return const AlertDialog(
        backgroundColor: Color.fromRGBO(39, 64, 87, 1),
        content:  Text(
          'Город уже выбран для отображения', 
          textAlign: TextAlign.center, 
          style: TextStyle(
            color: Color.fromRGBO(194, 184, 255, 1), 
            fontSize: 24, 
            fontWeight: FontWeight.bold
          ),
        ),
      );
    }
  } 

  Future<void> _loadData() async {
    FutureApi future = FutureApi();
    Updateapi weather = Updateapi();
    timeZoneName timezone = timeZoneName();
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

    for (var cityMap in AppConstants.cityCountryMap) {
      String city = cityMap["city"];
      var time = await timezone.getWeather(city);
      if (time != null) {
          futures.add(time);
      }
    }

    await Future.wait(futures);

    for(int i = 0; i < AppConstants.cityCountryMap.length; i++){
      if (AppConstants.cityCountryMap[i]["city"] == AppConstants.weather[i]["city"]){
        AppConstants.cityCountryMap[i]["temperature"] = AppConstants.weather[i]["temperature"];
        AppConstants.cityCountryMap[i]["weather_status"] = AppConstants.weather[i]["weather_status"];
      }
    }
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
  WeatherScreen wap = WeatherScreen();
  
  @override
  Widget build(BuildContext context) {
    // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * widget.width; 
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * widget.height;
    //Функции
    WeatherHelper weatherHelper = WeatherHelper();

    String countryname;

    if (widget.country == "Соединенные Штаты Америки"){
      countryname = "США";
    }
    else {
      countryname = widget.country;
    }
   
    return Stack(
      children: [
        Container(
          width: rectangleWidth,
          height: rectangleHeight,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromRGBO(194, 184, 255, 0.35), // Начальный цвет градиента
                Color.fromRGBO(194, 184, 255, 0), // Конечный цвет градиента
              ],
            ),
          ),
        ),
        Container(
          width: rectangleWidth,
          height: rectangleHeight,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(194, 184, 255, 0.35), // Начальный цвет градиента
                Color.fromRGBO(194, 184, 255, 0), // Конечный цвет градиента
              ],
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            width: rectangleWidth,
            height: rectangleHeight,
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Column(
              children: [
                Expanded(
                flex: 3,
                  child: 
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 16,),
                            Text(
                              widget.temperature + AppConstants.temperature,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]
                        )
                      ),
                      Expanded(
                        child: weatherHelper.buildWeatherImage(widget.weather)
                      ),
                    ],
                  )
                ),
                Expanded(
                  flex: 2,
                  child: 
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              widget.city,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              countryname,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]
                        )
                      ),
                      Expanded(
                        child: Text(
                          widget.weather,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        )
      ]
    );
  }
}