import 'dart:async';
import 'package:SkyView/API/futureApi.dart';
import 'package:SkyView/API/updateApi.dart';
import 'package:SkyView/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/widgets/cityList/card.dart';
import 'package:SkyView/widgets/cityList/search.dart';
import 'package:SkyView/widgets/background.dart';
import 'package:intl/intl.dart';  

class CitiesList extends StatefulWidget {
  final int currentIndex;
  CitiesList({Key? key, required this.currentIndex}) : super(key: key);

  @override
  _CitiesListState createState() => _CitiesListState();
}

class _CitiesListState extends State<CitiesList> {
  Updateapi weather = Updateapi();

  Future up() async{
    for (var cityMap in AppConstants.cityCountryMap) {
      String city = cityMap["city"];
      await weather.getWeather(city);
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

  Future updateList() async {
    FutureApi future = FutureApi();
    List<Map<String, dynamic>> days = forecastForFiveDays();
    for (var day in days) {
      String city = day["city"];
      String date = day["date"];
      await future.getWeather(city, date);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        for (var cityMap in AppConstants.cityCountryMap) {
          String city = cityMap["city"];
          await weather.getWeather(city);
        }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(currentIndex: widget.currentIndex,)));   
        setState(() {});                
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const Background(
              height: 1,
              width: 1,
              picture: "assets/images/background_city.jpg",
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ),
            SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.04,),
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight * 0.12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: screenWidth * 0.05,),
                        InkWell(
                          onTap: () async {
                            AppConstants.weather = [];
                            AppConstants.data = [];
                            //Погода в городах  
                            print("main");
                            print(AppConstants.weather);
                            print("table");
                            print(AppConstants.data);
                            await up();
                            await updateList();
                            print("main");
                            print(AppConstants.weather);
                            print("table");
                            print(AppConstants.data);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(currentIndex: widget.currentIndex,)));
                            setState(() {});
                          },
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(const Color.fromARGB(255, 255, 255, 255), BlendMode.modulate),
                            child: SizedBox(
                              width: screenWidth * 0.10,
                              height: screenHeight,
                              child: Image.asset("assets/images/arrow.png"),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.04,),
                        SearchContainerWidget(width: 0.68, height: 0.05,),
                        SizedBox(width: screenWidth * 0.10,),
                      ]
                    ),
                  ), 
                  Container(
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.80,
                    padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    child: AppConstants.cityCountryMap.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Добавьте город для отображения погоды",
                                  style: TextStyle(
                                    color: Color.fromRGBO(194, 184, 255, 1),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: screenHeight * 0.10,),
                              ]
                            )
                        )
                        : ListView.builder(
                            itemCount: AppConstants.cityCountryMap.length,
                            itemBuilder: (context, index) {
                              final cityName = AppConstants.cityCountryMap[index]["city"];
                              final countryName = AppConstants.cityCountryMap[index]["country"] ?? '';
                              final temperature = AppConstants.cityCountryMap[index]["temperature"].toString() ?? '-';
                              final weather = AppConstants.cityCountryMap[index]["weather_status"] ?? '';
                              return Column(
                                children: [
                                  Dismissible(
                                    key: Key(cityName), // Уникальный ключ для элемента списка
                                    direction: DismissDirection.endToStart, // Направление свайпа
                                    onDismissed: (direction) {
                                      setState(() {
                                        // Удаление города из списка
                                        AppConstants.weather.removeWhere((element) => element["city"] == cityName);
                                        AppConstants.data.removeWhere((element) => element["city"] == cityName);
                                        AppConstants.cityCountryMap.removeWhere((element) => element["city"] == cityName);
                                        AppConstants.savePreferences();
                                      });
                                    },
                                    background: Container(
                                      alignment: Alignment.centerLeft,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(39, 64, 87, 0),
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.width * 0.60), // Добавляем отступ слева
                                      child: const Icon(
                                        Icons.delete, // Иконка удаления
                                        size: 64.0, // Увеличиваем размер иконки
                                        color: Colors.white,
                                      ), // Иконка удаления
                                    ),
                                    child: ListTile(
                                      title: CardCities(
                                        height: 0.22,
                                        width: 0.8,
                                        temperature: temperature,
                                        city: cityName,
                                        country: countryName,
                                        weather: weather,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                  SizedBox(height: screenHeight * 0.04,),  
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}
