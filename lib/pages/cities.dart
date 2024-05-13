import 'dart:async';
import 'dart:ui';
import 'package:SkyView/API/futureApi.dart';
import 'package:SkyView/API/timeZoneName.dart';
import 'package:SkyView/API/updateApi.dart';
import 'package:SkyView/pages/main_page.dart';
import 'package:SkyView/pages/start/entry.dart';
import 'package:SkyView/widgets/reorderable.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          barrierDismissible: false, 
          builder: (BuildContext context) {
            return Entry();
          },
        );
        AppConstants.timeZoneName = [];
        AppConstants.weather = [];
        AppConstants.data = [];
        await _loadData();
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(currentIndex: 0)));   
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
                        InkWell(
                          onTap: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false, // блокируем закрытие окна при нажатии вне его
                              builder: (BuildContext context) {
                                return Entry();
                              },
                            );
                            AppConstants.timeZoneName = [];
                            AppConstants.weather = [];
                            AppConstants.data = [];
                            await _loadData();
                            Navigator.pop(context);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(currentIndex: 0)));
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
                        : ReorderableListView.builder(
                          proxyDecorator: proxyDecorator,
                          itemCount: AppConstants.cityCountryMap.length,
                          onReorder: (int oldIndex, int newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) {
                                newIndex -= 1;
                              } 
                              final item = AppConstants.cityCountryMap.removeAt(oldIndex);
                              AppConstants.cityCountryMap.insert(newIndex, item);
                            });
                          },
                          itemBuilder: (context, index) {
                            final cityName = AppConstants.cityCountryMap[index]["city"];
                            final countryName = AppConstants.cityCountryMap[index]["country"] ?? '';
                            final temperature = AppConstants.cityCountryMap[index]["temperature"].toString() ?? '-';
                            final weather = AppConstants.cityCountryMap[index]["weather_status"] ?? '';
                            return ReorderableItem(
                              key: ValueKey(cityName),
                              onReorder: (ReorderableItem ) { 
                                
                              },
                              child: Dismissible(
                                key: Key(cityName),
                                onDismissed: (direction) {
                                  if (direction == DismissDirection.endToStart || direction == DismissDirection.startToEnd) { // свайп влево
                                    setState(() {
                                      AppConstants.cityCountryMap.removeAt(index);
                                      AppConstants.savePreferences();
                                    });
                                  }
                                },
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  color: Colors.transparent,
                                  child: Icon(Icons.delete, size: 46, color: Colors.white,),
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

  Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 6, animValue)!;
          return Material(
            elevation: elevation,
            color: Colors.transparent,
            shadowColor: null,
            child: child,
          );
        },
        child: child,
      );
    }
}
