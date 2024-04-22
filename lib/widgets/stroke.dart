import 'package:SkyView/Appconstants/constants.dart';
import 'package:flutter/material.dart';

class Stroke extends StatelessWidget {
  final double rectangleWidth;
  final double rectangleHeight;
  final String date;
  final String temperature;

  Stroke({required this.rectangleWidth, required this.rectangleHeight, required this.date, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: rectangleWidth,
      height: rectangleHeight,
      child: Row(
        children: [
          SizedBox(width: rectangleWidth * 0.083),
          SizedBox(
            width: rectangleWidth * 0.4,
            child: Text(
              date,
              style: TextStyle(
                color: AppConstants.nightColor, // замените на AppConstants.nightColor
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(width: rectangleWidth * 0.16,),
          SizedBox(
            width: rectangleWidth * 0.2,
            child: Text(
              temperature,
              style: TextStyle(
                color: AppConstants.nightColor, // замените на AppConstants.nightColor
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )
          )
        ],
      ),
    );
  }
}