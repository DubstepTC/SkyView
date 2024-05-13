import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/widgets/stroke.dart';
import 'package:flutter/material.dart';

class TableFrame extends StatelessWidget {
  final double width;
  final double height; 
  final int currentIndex;

  const TableFrame({Key? key, required this.width, required this.height, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the width of the rectangle
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * width; 
    // Calculate the height of the rectangle
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * height;

    int var1 = currentIndex * 5 + 0;
    int var2 = currentIndex * 5 + 1;
    int var3 = currentIndex * 5 + 2;
    int var4 = currentIndex * 5 + 3;
    int var5 = currentIndex * 5 + 4;
    
    return Container(
      width: rectangleWidth,
      height: rectangleHeight,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(39, 64, 87, 0.35),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
      child: Column (
        children: [
          SizedBox(
            width: rectangleWidth,
            height: rectangleHeight * 0.195,
            child: Row(
              children: [
                SizedBox(width: rectangleWidth * 0.05),
                SizedBox(
                  width: rectangleWidth * 0.4,
                  child: const Text(
                    "Прогноз на 5 дней",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: rectangleWidth * 0.2,),
                SizedBox(
                  width: rectangleWidth * 0.2,
                  child: const Text(
                    "Подробнее",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                ),
                SizedBox(width: rectangleWidth * 0.1),
              ],
            ),
          ),
          Container(
            width: screenWidth * 0.9,
            height: screenHeight * 0.001,
            decoration: BoxDecoration(
              color: AppConstants.backColor,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
          ),
          Stroke(rectangleWidth: screenWidth, rectangleHeight: screenHeight * 0.063, date: AppConstants.data[var1]["data"] + "\n" + AppConstants.data[var1]["status"], temperature: (AppConstants.data[var1]["temperature_min"]).toString() + AppConstants.temperature + " / " + (AppConstants.data[var1]["temperature_max"]).toString() + AppConstants.temperature),
          Stroke(rectangleWidth: screenWidth, rectangleHeight: screenHeight * 0.063, date: AppConstants.data[var2]["data"] + "\n" + AppConstants.data[var2]["status"], temperature: (AppConstants.data[var2]["temperature_min"]).toString() + AppConstants.temperature + " / " + (AppConstants.data[var2]["temperature_max"]).toString() + AppConstants.temperature),
          Stroke(rectangleWidth: screenWidth, rectangleHeight: screenHeight * 0.063, date: AppConstants.data[var3]["data"] + "\n" + AppConstants.data[var3]["status"], temperature: (AppConstants.data[var3]["temperature_min"]).toString() + AppConstants.temperature + " / " + (AppConstants.data[var3]["temperature_max"]).toString() + AppConstants.temperature),
          Stroke(rectangleWidth: screenWidth, rectangleHeight: screenHeight * 0.063, date: AppConstants.data[var4]["data"] + "\n" + AppConstants.data[var4]["status"], temperature: (AppConstants.data[var4]["temperature_min"]).toString() + AppConstants.temperature + " / " + (AppConstants.data[var4]["temperature_max"]).toString() + AppConstants.temperature),
          Stroke(rectangleWidth: screenWidth, rectangleHeight: screenHeight * 0.063, date: AppConstants.data[var5]["data"] + "\n" + AppConstants.data[var5]["status"], temperature: (AppConstants.data[var5]["temperature_min"]).toString() + AppConstants.temperature + " / " + (AppConstants.data[var5]["temperature_max"]).toString() + AppConstants.temperature),
        ],
      ),
    );
  }
}