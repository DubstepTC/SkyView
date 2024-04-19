import 'package:flutter/material.dart';
import 'package:SkyView/Appconstants/constants.dart';

class CityListWidget extends StatelessWidget {
  final double width;
  final double height;
  final int currentIndex;

  CityListWidget({Key? key, required this.width, required this.height, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * height,
      width: MediaQuery.of(context).size.width * width,
      child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppConstants.cityCountryMap.keys.toList()[currentIndex],
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8), // Добавляем небольшой отступ между индикаторами и названием города
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  AppConstants.cityCountryMap.keys.length,
                  (i) => Icon(
                    Icons.fiber_manual_record,
                    color: i == currentIndex ? Colors.white : Colors.grey,
                    size: 10,
                  ),
                ),
              ),
            ],
          )
          );
        }
}