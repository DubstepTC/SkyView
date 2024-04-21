import 'package:flutter/material.dart';
import 'package:SkyView/Appconstants/constants.dart';

class CityListWidget extends StatefulWidget {
  final double width;
  final double height;
  final int currentIndex;

  CityListWidget({Key? key, required this.width, required this.height, required this.currentIndex});
  @override
  _CityListWidgetState createState() => _CityListWidgetState();
}

  class _CityListWidgetState extends State<CityListWidget> {

  @override
  Widget build(BuildContext context) {
    if (AppConstants.cityCountryMap.isEmpty) {
      return SizedBox(); // Если список пуст, возвращаем пустой контейнер
    } else {
      return Container(
        height: MediaQuery.of(context).size.height * widget.height,
        width: MediaQuery.of(context).size.width * widget.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppConstants.cityCountryMap[widget.currentIndex]["city"],
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8), // Добавляем небольшой отступ между индикаторами и названием города
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                AppConstants.cityCountryMap.length,
                (i) => Icon(
                  Icons.fiber_manual_record,
                  color: i == widget.currentIndex ? Colors.white : Colors.grey,
                  size: 10,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}