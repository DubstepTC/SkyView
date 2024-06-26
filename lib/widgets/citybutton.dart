import 'package:SkyView/API/futureApi.dart';
import 'package:SkyView/API/openApi.dart';
import 'package:SkyView/API/timeZoneName.dart';
import 'package:SkyView/API/updateApi.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/pages/main_page.dart';
import 'package:SkyView/pages/start/entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OvalButtonWidget extends StatefulWidget {
  final VoidCallback onPressed;
  final String name; 

  const OvalButtonWidget({Key? key, required this.onPressed, required this.name}) : super(key: key);

   @override
  _OvalButtonWidgetState createState() => _OvalButtonWidgetState();
}

class _OvalButtonWidgetState extends State<OvalButtonWidget> {

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

  WeatherScreen wap = WeatherScreen();
  Updateapi weather = Updateapi();

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        showDialog(
          context: context,
          barrierDismissible: false, // блокируем закрытие окна при нажатии вне его
          builder: (BuildContext context) {
            return Entry();
          },
        );
        AppConstants.cityWeather = [];
        await wap.getWeather(widget.name);
        Map<String, dynamic> cityData = {
          "city": AppConstants.cityWeather[0]["city"],
          "country": AppConstants.cityWeather[0]["country"],
          "temperature": AppConstants.cityWeather[0]["temperature"],
          "weather_status": AppConstants.cityWeather[0]["weather_status"],
        };
        add(cityData);
        AppConstants.savePreferences();
        AppConstants.cityWeather = [];
        AppConstants.timeZoneName = [];
        AppConstants.weather = [];
        AppConstants.data = [];
        await _loadData();
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen(currentIndex: 0)));   
        setState(() {});   
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 40) / 3,
        height: (MediaQuery.of(context).size.width - 40) /3,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(39, 64, 87, 0.35),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: Text(
            widget.name,
            style: const TextStyle(
              color: Color.fromRGBO(194, 184, 255, 1),
              fontSize: 16.0,
              fontWeight: FontWeight.bold 
            ),
          ),
        ),
      ),
    );
  }
}
