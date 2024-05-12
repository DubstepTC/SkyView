import 'package:SkyView/pages/main_page.dart';
import 'package:SkyView/widgets/hours.dart';
import 'package:SkyView/widgets/box_day.dart';
import 'package:SkyView/widgets/sun.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SkyView/Appconstants/constants.dart';

class DayScreen extends StatefulWidget {
  final int currentIndex;
  final int time;

  const DayScreen({Key? key, required this.currentIndex, required this.time}) : super(key: key);

  @override
  _DayScreenState createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  late int index = widget.currentIndex;


  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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

    String pressure;

    if (AppConstants.pressure == "Миллиметр ртутного столба (мм рт. ст)") {
      pressure = " мм рт.ст.";
    }
    else if (AppConstants.pressure == "Физическая атмосфера (атм)") {
      pressure = " атм";
    }
    else {
      pressure = " мбар";
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(currentIndex: widget.currentIndex,)));            
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(194, 184, 255, 1.0),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/sunrise_background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.7),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(currentIndex: widget.currentIndex,)));            
                            setState(() {});
                          },
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode( Color.fromARGB(255, 255, 255, 255), BlendMode.modulate),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.height,
                              child: Image.asset("assets/images/arrow.png"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: const Text(
                            "Подробная информация",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0,
                  ),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Box(width: 0.4, height: 0.15, meaning: AppConstants.weather[widget.currentIndex]["temperature"].toString() + " " + AppConstants.temperature, name: "Температура",),
                            const SizedBox(width: 10,),
                            Box(width: 0.4, height: 0.15, meaning: AppConstants.weather[widget.currentIndex]["feelslike_c"].toString() + " " + AppConstants.temperature, name: "Ощущается",)
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Box(width: 0.4, height: 0.15, meaning: AppConstants.weather[widget.currentIndex]["uv"].toString(), name: "Уф",),
                            const SizedBox(width: 10,),
                            Box(width: 0.4, height: 0.15, meaning: AppConstants.hours[widget.currentIndex]["pressure_mb"].toString() + "\n" + pressure, name: "Давление",)
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Box(width: 0.4, height: 0.15, meaning: AppConstants.weather[widget.currentIndex]["humidity"].toString() + "%", name: "Влажность",),
                            const SizedBox(width: 10,),
                            Box(width: 0.4, height: 0.15, meaning: AppConstants.hours[widget.currentIndex]["chance"].toString() + "%", name: "Вероятность осадков",)
                          ],
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                  SunriseSunsetWidget(),
                  const SizedBox(height: 10,),
                  const SizedBox(
                    child: Text(
                      "Прогноз на 24 часа",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  HoursList(time: widget.time,),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
