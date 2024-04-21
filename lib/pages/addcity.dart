import 'package:SkyView/API/openApi.dart';
import 'package:SkyView/pages/cities.dart';
import 'package:SkyView/widgets/cityList/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/widgets/background.dart';

class SearchResultsScreen extends StatefulWidget {
  final int currentIndex;
  SearchResultsScreen({Key? key, required this.currentIndex}) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  TextEditingController searchController = TextEditingController();

  WeatherScreen wap = WeatherScreen();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                        onTap: () {
                          AppConstants.cityWeather = [];
                          setState(() {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CitiesList(currentIndex: 0,)));
                          });
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
                                ),
                              ),
                              Expanded(
                                flex: 2,  
                                child: IconButton(
                                  icon: Icon(Icons.search, color: Colors.white,),
                                  onPressed: () async {
                                    String searchText = searchController.text;
                                    wap.getWeather(searchText);
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
                                      AppConstants.cityCountryMap.add(cityData);
                                      setState((){});
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
                                      Icons.add, // Иконка удаления
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
              ],
            ),
          ),
        ]
      ),
    );
  }
}
