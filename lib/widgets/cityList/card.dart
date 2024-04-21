import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:SkyView/function/weatherImage.dart';

class CardCities extends StatelessWidget {
  final double width;
  final double height; 
  final String temperature;
  final String city;
  final String country;
  final String weather;

  const CardCities({super.key,required this.width, required this.height, required this.temperature, required this.city, required this.country , required this.weather});

  @override
  Widget build(BuildContext context) {
    // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * width; 
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * height;
    //Функции
    WeatherHelper weatherHelper = WeatherHelper();
   
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
          onTap: () {
            int index = AppConstants.cityCountryMap.indexWhere((element) => element["city"] == city);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(
                  currentIndex: index,
                ),
              ),
            );
          },
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
                              temperature + AppConstants.temperature,
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
                        child:  weatherHelper.buildWeatherImage(weather)
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
                              city,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              country,
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
                          weather,
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