import 'package:SkyView/function/weatherImage.dart';
import 'package:flutter/material.dart';
import 'package:SkyView/Appconstants/constants.dart';

class HoursList extends StatelessWidget {
  final int time;

  const HoursList({super.key, required this.time});
  

  @override
  Widget build(BuildContext context) {

    //Функции
    WeatherHelper weatherHelper = WeatherHelper();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.17,
      width: MediaQuery.of(context).size.width * 0.95,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 25,
        itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.30,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(39, 64, 87, 0.35),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Row(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.025,)
                    ],
                  ),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: weatherHelper.buildWeatherImage("Ясно")
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            
                            '20' + AppConstants.temperature,
                            style: TextStyle(
                              color: AppConstants.nightColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '5 km/h',
                            style: TextStyle(
                              color: AppConstants.nightColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.018,)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (index == 0) 
                        Text(
                          "Cейчас",
                          style: TextStyle(
                            color: AppConstants.nightColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center
                        )
                      else if (time + index < 24)
                        Text(
                          (time + index).toString() + ":00",
                          style: TextStyle(
                            color: AppConstants.nightColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center
                        )
                      else
                        Text(
                          (time + index - 24).toString() + ":00",
                          style: TextStyle(
                            color: AppConstants.nightColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center
                        )
                    ],
                  )
                ],
              ),
            );
        },
      ),
    );
  }
}
