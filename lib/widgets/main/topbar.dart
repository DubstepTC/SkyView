import 'package:SkyView/API/openApi.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/function/animation.dart';
import 'package:SkyView/pages/cities.dart';
import 'package:SkyView/pages/intresting.dart';
import 'package:SkyView/pages/map.dart';
import 'package:SkyView/pages/settings.dart';
import 'package:SkyView/pages/start/firstentry/introductionTwo.dart';
import 'package:flutter/material.dart';
import 'package:SkyView/widgets/main/city.dart';


class Top extends StatefulWidget {
  final double width;
  final double height; 
  final int currentIndex;

  Top({super.key, required this.width, required this.height, required this.currentIndex});


  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * widget.width; 
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * widget.height;
  
    return SizedBox(
      width: rectangleWidth,
      height: rectangleHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width:  rectangleWidth * 0.05,),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CitiesList(currentIndex: widget.currentIndex,)));
              setState(() {});
            },
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(const Color.fromARGB(255, 255, 255, 255), BlendMode.modulate), // Замените Colors.red на нужный вам цвет
              child: SizedBox(
                width: rectangleWidth * 0.10,
                height: rectangleHeight,
                child: Image.asset("assets/images/plus.png"),
              ),
            ),
          ),
          SizedBox(width:  rectangleWidth * 0.10,),
          CityListWidget(
            height: rectangleHeight, 
            width: 0.5,
            currentIndex: widget.currentIndex,
          ),
          SizedBox(width:  rectangleWidth * 0.10,),
          InkWell(
            onTap: () async {
              final String? userChoice = await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return Align(
                    alignment: Alignment.topRight,
                    child: SimpleDialog(
                      backgroundColor: Color.fromRGBO(39, 64, 87, 1),
                      children: <Widget>[
                        SimpleDialogOption(
                          onPressed: () { Navigator.pop(context, 'Интересное'); },
                          child: Text(
                            'Интересное',
                            style: TextStyle(
                              color: AppConstants.nightColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center
                          ),
                        ),
                        const SizedBox(height: 20,),
                        SimpleDialogOption(
                          onPressed: () { Navigator.pop(context, 'Карта'); },
                          child: Text(
                            'Карта',
                            style: TextStyle(
                              color: AppConstants.nightColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center
                          ),
                        ),
                        const SizedBox(height: 20,),
                        SimpleDialogOption(
                          onPressed: () { Navigator.pop(context, 'Настройки'); },
                          child: Text(
                            'Настройки',
                            style: TextStyle(
                              color: AppConstants.nightColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );


              if (userChoice != null) {
                if (userChoice == 'Интересное') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Intresting(currentIndex: widget.currentIndex,)),
                  );
                } else if (userChoice == 'Настройки') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings(currentIndex: widget.currentIndex)),
                  );
                } else if (userChoice == 'Карта') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyWebViewPage('https://www.windy.com/?55.470,37.224,7')),
                  );
                }
              }
            },
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(const Color.fromARGB(255, 255, 255, 255), BlendMode.modulate), // Замените Colors.red на нужный вам цвет
              child: SizedBox(
                width: rectangleWidth * 0.10,
                height: rectangleHeight,
                child: Image.asset("assets/images/points.png"),
              ),
            ),
          ),
          SizedBox(width:  rectangleWidth * 0.05,),
        ],
      ),
    );
  }
}