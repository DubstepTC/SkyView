import 'package:SkyView/pages/privacy_page.dart';
import 'package:flutter/material.dart';

class RrivacyPolicyWidget extends StatelessWidget {
  final double width;
  final double height;

  RrivacyPolicyWidget({super.key, required this.width, required this.height,});

  @override
  Widget build(BuildContext context) {
    // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * width; 
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PrivacyPolicy()),
        );
      },
      child: Container(
        width: rectangleWidth,
        height: rectangleHeight,
        padding: const EdgeInsets.all(16.0),
        child: const Row(
          children: [ 
            Expanded(
              flex: 6,
              child: Text(
                'Политика конфиденциальности',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color.fromRGBO(194, 184, 255, 1),
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '>',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(194, 184, 255, 1),
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}