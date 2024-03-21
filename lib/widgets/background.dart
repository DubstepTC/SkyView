import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final String picture;
  final double width;
  final double height; 

  const Background({super.key, required this.width, required this.height, required this.picture});

  @override
  Widget build(BuildContext context) {
    // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * width; 
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * height;

  
    return SizedBox(
      width: rectangleWidth,
      height: rectangleHeight,
      child: Stack(
        children: [
        Image.asset(picture, fit: BoxFit.fitHeight, height: rectangleHeight, width: rectangleWidth,),
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              color:  Color.fromARGB(0, 0, 0, 0),
            ),
          ),
        ),
      ]
      )
    );
  }
}