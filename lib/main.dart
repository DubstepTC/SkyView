import 'package:SkyView/API/updateApi.dart';
import 'package:flutter/material.dart';
import 'package:SkyView/pages/main_page.dart';
import 'package:SkyView/Appconstants/constants.dart';

void main() async {
  Updateapi weather = Updateapi();
  WidgetsFlutterBinding.ensureInitialized();
  await AppConstants.initialize();

  List<String> cities = [];
  for (var map in AppConstants.cityCountryMap) {
      cities.add(map["city"]);
  }
  print("--------------------------------------------------------");
  print(cities);

  for (var cityMap in AppConstants.cityCountryMap) {
    String city = cityMap["city"];
    await weather.getWeather(city);
    print(AppConstants.weather);
  }

  print("City");
  print(AppConstants.weather);

  runApp(const MainApp());
  
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PopScope(
        child: MainScreen(currentIndex: 0,),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
