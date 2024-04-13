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
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
  
  return Scaffold(
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
                      onTap: () {
                        Navigator.pop(context);
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
                height: screenHeight * 0.40, 
                width: screenWidth * 0.8,
                child: CustomContainerWidget(nameContainer: "Температура", choice: "Привет",),
              ),  
              SizedBox(
                height: screenHeight * 0.40, 
                width: screenWidth * 0.8,
              ),   
            ],
          ),
        ),
      ]
    ),
  );
}
}
