import 'package:SkyView/API/futureApi.dart';
import 'package:SkyView/API/updateApi.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/pages/main_page.dart';
import 'package:SkyView/pages/start/entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OvalButtonWidget extends StatefulWidget {
  final VoidCallback onPressed;
  final String name; 

  const OvalButtonWidget({Key? key, required this.onPressed, required this.name}) : super(key: key);

   @override
  _OvalButtonWidgetState createState() => _OvalButtonWidgetState();
}

class _OvalButtonWidgetState extends State<OvalButtonWidget> {
  Updateapi weather = Updateapi();

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

  Future up() async{
    await weather.getWeather(widget.name);
    for(int i = 0; i < AppConstants.weather.length; i++){
      if (AppConstants.weather[i]['city'] == widget.name){
        Map<String, dynamic> cityData = {
          "city": widget.name,
          "country": AppConstants.weather[i]['country'],
          "temperature": AppConstants.weather[i]['temperature'],
          "weather_status": AppConstants.weather[i]['weather_status'],
        };
        AppConstants.cityCountryMap.add(cityData);
      }
    }
  }

  Future updateList() async {
    FutureApi future = FutureApi();
    List<Map<String, dynamic>> days = forecastForFiveDays();
    for (var day in days) {
      String city = day["city"];
      String date = day["date"];
      await future.getWeather(city, date);
    }
    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(currentIndex: 0)));
    setState(() {});
    AppConstants.savePreferences();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        showDialog(
          context: context,
          barrierDismissible: false, // блокируем закрытие окна при нажатии вне его
          builder: (BuildContext context) {
            return Entry();
          },
        );
        AppConstants.data = [];
        await up();
        await updateList();
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 40) / 3,
        height: (MediaQuery.of(context).size.width - 40) /3,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(39, 64, 87, 0.35),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: Text(
            widget.name,
            style: const TextStyle(
              color: Color.fromRGBO(194, 184, 255, 1),
              fontSize: 16.0,
              fontWeight: FontWeight.bold 
            ),
          ),
        ),
      ),
    );
  }
}
