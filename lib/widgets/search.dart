import 'package:SkyView/Appconstants/constants.dart';
import 'package:flutter/material.dart';

class SearchContainerWidget extends StatelessWidget {
  final double width;
  final double height;

  SearchContainerWidget({required this.width, required this.height});

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
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppConstants.backColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: TextField(
              style: TextStyle(color: AppConstants.nightColor),
              decoration: InputDecoration(
                hintText: 'Введите местоположение',
                hintStyle: TextStyle(
                  color: AppConstants.nightColor, // Specify the color you want for the hint text
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.white,),
              onPressed: () {
                // Add your search logic here
              },
            ),
          ),
        ],
      ),
    );
  }
}