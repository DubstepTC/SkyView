import 'package:SkyView/API/hoursApi.dart';
import 'package:SkyView/API/sunriseApi.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/function/weatherImage.dart';
import 'package:SkyView/pages/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MainFrame extends StatelessWidget {
  final double width;
  final double height; 
  final int currentIndex;

  const MainFrame({Key? key, required this.width, required this.height, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * width; 
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * height;

    WeatherHelper weatherHelper = WeatherHelper();
    SunriseApi sun = SunriseApi();
    HoursApi gethours = HoursApi();

    return GestureDetector(
      onTap: () async{
        
        String time = AppConstants.timeZoneName[currentIndex]["localtime"];
        List<String> dateTimeParts = time.split(" ");

        String day = dateTimeParts[0];
        int hours = int.parse(dateTimeParts[1].split(":").first);
        await sun.getSunrise(AppConstants.weather[currentIndex]['city']);
        
        List<Future> allFutures = [];

        DateTime baseDateTime = DateTime.parse(day); // Преобразуем строку даты в DateTime

        AppConstants.hours = [];
        for (int i = 0; i < 25; i++) {
          int nextHour = (hours + i) % 24;
          
          if (nextHour == 0 && i > 0) {
            baseDateTime = baseDateTime.add(Duration(days: 1)); // Увеличиваем на 1 день
          }
          
          String updatedDate = baseDateTime.toIso8601String(); // Преобразуем дату обратно в строку
          
          allFutures.add(gethours.getHours(AppConstants.weather[currentIndex]['city'], updatedDate, nextHour.toString(), currentIndex));
        }
        await Future.forEach(allFutures, (future) => future);
        AppConstants.hours.sort((a, b) => a['data'].compareTo(b['data']));
        AppConstants.hours[0]["status"] = AppConstants.weather[currentIndex]['weather_status'];
        AppConstants.hours[0]["temperature"] = AppConstants.weather[currentIndex]['temperature'];
        AppConstants.hours[0]["wind_speed"] = AppConstants.weather[currentIndex]['wind_kph'];
        Navigator.push(context, MaterialPageRoute(builder: (context) => DayScreen(currentIndex: currentIndex, time: hours,)));
      },
      child: Container(
        width: rectangleWidth,
        height: rectangleHeight,
        decoration: const BoxDecoration(
          color:  Color.fromRGBO(39, 64, 87, 0.35),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          children: [
            SizedBox(
              height: rectangleHeight * 0.25,
              width: rectangleWidth,
              child: Column(
                children: [
                  SizedBox(height: rectangleHeight * 0.08,),
                  const Text(
                  "Сегодня", 
                  style: TextStyle(
                    color: Color.fromRGBO(194, 184, 255, 1),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ), 
                  textAlign: TextAlign.center,
                )
                ]
              )   
            ),
            SizedBox(
              height: rectangleHeight * 0.45,
              width: rectangleWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox( width: rectangleWidth * 0.25, height: rectangleHeight * 0.25, child: weatherHelper.buildWeatherImage(AppConstants.weather[currentIndex]["weather_status"]),),
                  SizedBox(width: screenWidth * 0.04,),
                  Text(
                    (AppConstants.weather[currentIndex]["temperature"]).toString(),
                    style: const TextStyle(
                      color: Color.fromRGBO(194, 184, 255, 1),
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Column(
                    children: [
                      SizedBox(height: rectangleHeight * 0.17),
                      Text(
                        " " + (AppConstants.temperature).toString(),
                        style: const TextStyle(
                          color: Color.fromRGBO(194, 184, 255, 1),
                          fontSize: 40,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ]
                  )
                ],
              ),
            ),
            SizedBox(
              height: rectangleHeight * 0.3,
              width: rectangleWidth,
              child: Column(
                children: [
                  SizedBox(height: rectangleHeight * 0.05,),
                  Text(
                    AppConstants.weather[currentIndex]["weather_status"],
                    style: const TextStyle(
                      color: Color.fromRGBO(194, 184, 255, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]
              ) 
            ),
          ],
        ),
      ),
    );
  }
}