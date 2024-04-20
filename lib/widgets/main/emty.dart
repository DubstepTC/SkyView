import 'package:SkyView/pages/cities.dart';
import 'package:SkyView/pages/settings.dart';
import 'package:flutter/material.dart';


class EmptyTop extends StatefulWidget {
  final double width;
  final double height; 
  final int currentIndex;

  EmptyTop({super.key, required this.width, required this.height, required this.currentIndex});


  @override
  // ignore: library_private_types_in_public_api
  _EmptyTopState createState() => _EmptyTopState();
}

class _EmptyTopState extends State<EmptyTop> {
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CitiesList(currentIndex: currentIndex,)),
              );
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
          SizedBox(width:  rectangleWidth * 0.50,),
          SizedBox(width:  rectangleWidth * 0.10,),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
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