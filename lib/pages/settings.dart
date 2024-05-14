import 'package:SkyView/function/temperature.dart';
import 'package:SkyView/function/speed.dart';
import 'package:SkyView/pages/main_page.dart';
import 'package:SkyView/widgets/estimation.dart';
import 'package:SkyView/widgets/privacy_policy.dart';
import 'package:SkyView/widgets/settings/field_of_construction.dart';
import 'package:flutter/material.dart';
import 'package:SkyView/widgets/background.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int currentIndex = 0;
  
@override
Widget build(BuildContext context) {
  Speedtranslation speed = Speedtranslation();
  Temperaturetranslation temperature = Temperaturetranslation();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
  
  return WillPopScope(
      onWillPop: () async {
          await speed.updateList();
          await temperature.updateList();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen(currentIndex: 0,)));
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
              picture: "assets/images/background_settings.jpg",
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
                          onTap: () async {
                            await speed.updateList();
                            await temperature.updateList();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainScreen(currentIndex: 0,)),
                            );
                            setState(() {});
                          },
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(const Color.fromARGB(255, 255, 255, 255), BlendMode.modulate), // Замените Colors.red на нужный вам цвет
                            child: SizedBox(
                              width: screenWidth * 0.10,
                              height: screenHeight,
                              child: Image.asset("assets/images/arrow.png"),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.12,),
                        const Text(
                          "Настройки",
                          style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: screenWidth * 0.25,),
                      ]
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.04, 
                    width: screenWidth * 0.9,
                    child: const Text("Единицы измерения", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.normal),),
                  ),
                  SizedBox(
                    height: screenHeight * 0.1, 
                    width: screenWidth * 0.95,
                    child: CustomContainerWidget(height: screenHeight * 0.08, width: screenWidth * 0.95, nameContainer: "Температура", choice: const ["°C", "°F"], con: "temperature",),
                  ), 
                  SizedBox(
                    height: screenHeight * 0.1, 
                    width: screenWidth * 0.95,
                    child: CustomContainerWidget(height: screenHeight * 0.08, width: screenWidth * 0.95, nameContainer: "Скорость ветра", choice: const ["Километры в час", "Шкала Бофорта", "Метры в секунду", "Мили в час", "Узлы"], con: "windSpeeed",),
                  ), 
                  SizedBox(
                    height: screenHeight * 0.16, 
                    width: screenWidth * 0.95,
                    child: CustomContainerWidget(height: screenHeight * 0.08, width: screenWidth * 0.95, nameContainer: "Единицы измерения атмосферного давления", choice: const ["Миллиметр ртутного столба (мм рт. ст)", "Физическая атмосфера (атм)", "Миллибар (мбар)"], con: "pressure",),
                  ), 
                  Container(
                    width: screenWidth * 0.86,
                    height: screenHeight * 0.002,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01, 
                    width: screenWidth * 0.9,
                  ),  
                  SizedBox(
                    height: screenHeight * 0.038, 
                    width: screenWidth * 0.9,
                    child: const Text("О приложении", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.normal),),
                  ),
                  SizedBox(
                    height: screenHeight * 0.08, 
                    width: screenWidth * 0.95,
                    child: Estimation(height: screenHeight * 0.08, width: screenWidth * 0.95,),
                  ),
                  SizedBox(
                    height: screenHeight * 0.08, 
                    width: screenWidth * 0.95,
                    child: RrivacyPolicyWidget(height: screenHeight * 0.08, width: screenWidth * 0.95,),
                  ),
                  SizedBox(
                    height: screenHeight * 0.19, 
                    width: screenWidth * 0.9,
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
