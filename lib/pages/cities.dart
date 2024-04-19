import 'package:flutter/material.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/widgets/card.dart';
import 'package:SkyView/widgets/search.dart';
import 'package:SkyView/widgets/background.dart';
import 'package:flutter/services.dart';

class CitiesAdd extends StatefulWidget {

  CitiesAdd({Key? key,}) : super(key: key);

  @override
  _CitiesAddState createState() => _CitiesAddState();
}

class _CitiesAddState extends State<CitiesAdd> {
  String searchText = '';

  List<String> filteredCities() {
    // Фильтрация городов на основе текста поиска
    return AppConstants.cityCountryMap.keys.where((city) {
      final normalizedCity = city.toLowerCase();
      final normalizedSearchText = searchText.toLowerCase();
      return normalizedCity.contains(normalizedSearchText);
    }).toList();
  }

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
                  height: screenHeight * 0.16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: screenWidth * 0.05,),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
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
                  child: ListView.builder(
                    itemCount: filteredCities().length,
                    itemBuilder: (context, index) {
                      final cityName = filteredCities()[index];
                      final countryName = AppConstants.cityCountryMap[cityName] ?? '';
                      return Column(
                        children: [
                          ListTile( 
                            title: CardCities(
                              height: 0.22, 
                              width: 0.8, 
                              temperature: "21", 
                              city: cityName, 
                              country: countryName, 
                              weather: "Ясно",
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                        ],
                      );
                    },
                  ),
                )  
              ],
            ),
          ),
        ]
      ),
    );
  }
}