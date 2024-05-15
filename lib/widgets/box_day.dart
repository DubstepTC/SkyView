import 'package:SkyView/Appconstants/constants.dart';
import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final double width;
  final double height;
  final String name;
  final String meaning;

  const Box({Key? key, required this.width, required this.height, required this.name, required this.meaning}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * width; 
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * height;

    return Container(
      width: rectangleWidth,
      height: rectangleHeight,
      decoration:  BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromRGBO(39, 64, 87, 0.35),
        border: Border.all(
            color: AppConstants.nightColor, // цвет фиолетовой рамки
            width: 1.0, // толщина рамки
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            meaning,
            style: TextStyle(
              color: AppConstants.nightColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            name,
            style: TextStyle(
              color: AppConstants.nightColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center, 
          ),
        ],
      ),
    );
  }
}