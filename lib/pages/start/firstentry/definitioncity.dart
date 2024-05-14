import 'dart:async';
import 'package:SkyView/API/futureApi.dart';
import 'package:SkyView/API/openApi.dart';
import 'package:SkyView/API/updateApi.dart';
import 'package:SkyView/pages/main_page.dart';
import 'package:SkyView/pages/start/entry.dart';
import 'package:SkyView/widgets/cityList/card.dart';
import 'package:SkyView/widgets/citybutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/widgets/background.dart';
import 'package:intl/intl.dart';

class DefinitionCity extends StatefulWidget {
  DefinitionCity({Key? key}) : super(key: key);

  @override
  _DefinitionCityState createState() => _DefinitionCityState();
}

class _DefinitionCityState extends State<DefinitionCity> {
  TextEditingController searchController = TextEditingController();
  Updateapi weather = Updateapi();

  Future add(cityData) async{
    AppConstants.cityCountryMap.add(cityData);
  } 

  WeatherScreen wap = WeatherScreen();

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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(currentIndex: 0)));
    setState(() {});
    AppConstants.savePreferences();
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
        return false;
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
                color: Color.fromRGBO(0, 0, 0, 0.6),
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
                        SizedBox(width: screenWidth * 0.04,),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.68,
                            height: MediaQuery.of(context).size.height * 0.05,
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: AppConstants.backColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: TextField(
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      hintText: 'Введите местоположение',
                                      hintStyle: TextStyle(
                                        color: AppConstants.nightColor,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      color: AppConstants.nightColor,
                                    ),
                                    onSubmitted: (String searchText) async{
                                      FocusScope.of(context).unfocus();
                                      String searchText = searchController.text;
                                      await wap.getWeather(searchText);
                                      setState(() {});
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 2,  
                                  child: IconButton(
                                    icon: Icon(Icons.search, color: Colors.white,),
                                    onPressed: () async {
                                      String searchText = searchController.text;
                                      await wap.getWeather(searchText);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.10,),
                      ]
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.80,
                    padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    child: AppConstants.cityWeather.isEmpty
                        ? Center(
                          child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            children: AppConstants.popularCities.map((city) {
                              return OvalButtonWidget(
                                onPressed: () {
                                },
                                name: city,
                              );
                            }).toList(),
                          ),
                        )
                        : ListView.builder(
                            itemCount: AppConstants.cityWeather.length,
                            itemBuilder: (context, index) {
                              final cityName = AppConstants.cityWeather[index]["city"];
                              final countryName = AppConstants.cityWeather[index]["country"] ?? '';
                              final temperature = AppConstants.cityWeather[index]["temperature"].toString() ?? '-';
                              final weather = AppConstants.cityWeather[index]["weather_status"] ?? '';
                              return Column(
                                children: [
                                  Dismissible(
                                    key: Key(cityName), // Уникальный ключ для элемента списка
                                    direction: DismissDirection.horizontal, // Направление свайпа
                                    onDismissed: (direction) {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false, // блокируем закрытие окна при нажатии вне его
                                        builder: (BuildContext context) {
                                          return Entry();
                                        },
                                      );
                                      setState(() {
                                        Map<String, dynamic> cityData = {
                                          "city": cityName,
                                          "country": countryName,
                                          "temperature": temperature,
                                          "weather_status": weather,
                                        };
                                        AppConstants.cityWeather = [];
                                        searchController.text = "";
                                        //Добавление города в список
                                        add(cityData).then((_) {
                                          up().then((_) {
                                            updateList().then((_) {
                                            });
                                          });
                                        });
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
                                        Icons.add, 
                                        size: 64.0, 
                                        color: Colors.white,
                                      ),
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
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}