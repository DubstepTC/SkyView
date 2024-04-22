import 'package:SkyView/Appconstants/constants.dart';
import 'package:flutter/material.dart';

class StripFarme extends StatelessWidget {
  final double width;
  final double height; 
  final int currentIndex;

  const StripFarme({super.key, required this.width, required this.height, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * width; 
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * height;

    String wind;

    if (AppConstants.windSpeed == "Километры в час") {
      wind = " км/ч";
    }
    else if (AppConstants.windSpeed == "Шкала Бофорта") {
      wind = " Б";
    }
    else if (AppConstants.windSpeed == "Метры в секунду") {
      wind = " м/с";
    }
    else if (AppConstants.windSpeed == "Мили в час") {
      wind = " миль/ч";
    }
    else {
      wind = " уз";
    }

  
    return Container(
      width: rectangleWidth,
      height: rectangleHeight,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(39, 64, 87, 0.35),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Row(
        children: [
          SizedBox(
            height: rectangleHeight,
            width: rectangleWidth * 0.05,
          ),
          SizedBox(
            height: rectangleHeight,
            width: rectangleWidth * 0.1,
            child: Image.asset("assets/images/humidity.png"),
          ),
          SizedBox(
            height: rectangleHeight,
            width: rectangleWidth * 0.15,
            child: Column(
              children: [
                SizedBox(height: rectangleHeight * 0.3),
                Text(
                  (AppConstants.weather[currentIndex]["humidity"]).toString() + "%", 
                  style: const TextStyle(
                    color: Color.fromRGBO(194, 184, 255, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ]
            ) 
          ),
          SizedBox(width: rectangleWidth * 0.07),
          SizedBox(
            height: rectangleHeight,
            width: rectangleWidth * 0.1,
            child: Image.asset("assets/images/uv.png"),
          ),
          SizedBox(
            height: rectangleHeight,
            width: rectangleWidth * 0.15,
            child: Column(
              children: [
                SizedBox(height: rectangleHeight * 0.3,),
                Text(
                  (AppConstants.weather[currentIndex]["uv"]).toString(), 
                  style: const TextStyle(
                    color: Color.fromRGBO(194, 184, 255, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ]
            )
          ),
          SizedBox(width: rectangleWidth * 0.03),
          SizedBox(
            height: rectangleHeight,
            width: rectangleWidth * 0.1,
            child: Image.asset("assets/images/wind.png"),
          ),
          SizedBox(
            height: rectangleHeight,
            width: rectangleWidth * 0.25,
            child: Column(
              children: [
                SizedBox(height: rectangleHeight * 0.3,),
                Text(
                  (AppConstants.weather[currentIndex]["wind_kph"]).toString() + wind, 
                  style: const TextStyle(
                    color: Color.fromRGBO(194, 184, 255, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ]
            )
          ),
        ],
      ),
    );
  }
}