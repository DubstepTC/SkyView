import 'package:flutter/material.dart';

class TableFrame extends StatelessWidget {
  final double width;
  final double height; 

  const TableFrame({super.key, required this.width, required this.height});

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
      decoration: const BoxDecoration(
        color: Color.fromRGBO(39, 64, 87, 0.35),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
    );
  }
}