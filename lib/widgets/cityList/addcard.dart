import 'package:SkyView/API/openApi.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:flutter/material.dart';
import 'package:SkyView/function/weatherImage.dart'; 

class AddCardCities extends StatefulWidget {
  final double width;
  final double height; 
  final String temperature;
  final String city;
  final String country;
  final String weather;

  const AddCardCities({super.key,required this.width, required this.height, required this.temperature, required this.city, required this.country , required this.weather});

  @override
    _AddCardCitiesState createState() => _AddCardCitiesState();
  }

  class _AddCardCitiesState extends State<AddCardCities> {

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
          onTap: () async{
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Color.fromRGBO(39, 64, 87, 1),
                  content: const Text(
                    'Хотите отслеживать погоду в городе?', 
                    textAlign: TextAlign.center, 
                    style: TextStyle(
                      color: Color.fromRGBO(194, 184, 255, 1), 
                      fontSize: 24, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text(
                            'Нет', 
                            textAlign: TextAlign.center, 
                            style: TextStyle(
                              color: Color.fromRGBO(194, 184, 255, 1), 
                              fontSize: 24, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text(
                            'Да', 
                            textAlign: TextAlign.center, 
                            style: TextStyle(
                              color: Color.fromRGBO(194, 184, 255, 1), 
                              fontSize: 24, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ).then((value) async {
              if (value != null && value) {
                AppConstants.cityWeather = [];
                await wap.getWeather(widget.city);
                Map<String, dynamic> cityData = {
                  "city": AppConstants.cityWeather[0]["city"],
                  "country": AppConstants.cityWeather[0]["country"],
                  "temperature": AppConstants.cityWeather[0]["temperature"],
                  "weather_status": AppConstants.cityWeather[0]["weather_status"],
                };
                AppConstants.cityWeather = [];
                add(cityData);
                AppConstants.savePreferences();
              }
            });
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