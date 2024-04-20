import 'package:SkyView/API/cityAPI.dart';
import 'package:flutter/material.dart';
import 'package:SkyView/pages/main_page.dart';
import 'package:SkyView/Appconstants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConstants.initialize();
  runApp(const MainApp());

   // Создание экземпляра класса CityDataProvider
  CityDataProvider cityDataProvider = CityDataProvider();
  
  // Вызов метода для загрузки городов
  await _loadCities(cityDataProvider);
}

Future<void> _loadCities(CityDataProvider cityDataProvider) async {
  try {
    List<Map<String, String>> cities = await cityDataProvider.getCities();
    // Далее вы можете обработать полученные города по вашему усмотрению
    print('Loaded cities: $cities');
  } catch (error) {
    print('Failed to load cities: $error');
  }
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
