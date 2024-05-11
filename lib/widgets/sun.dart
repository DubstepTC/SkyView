import 'package:SkyView/Appconstants/constants.dart';
import 'package:flutter/material.dart';

class SunriseSunsetWidget extends StatelessWidget {
  const SunriseSunsetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.15,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(39, 64, 87, 0.35),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Sunrise and sunset times
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Восход     " + AppConstants.sunrise[0]["sunrise"],
                style: TextStyle(
                  color: AppConstants.nightColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Закат       " + AppConstants.sunrise[0]["sunset"],
                style: TextStyle(
                  color: AppConstants.nightColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          // Custom Paint for Parabola
         Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.34,
            child: Image.asset(
              'assets/signs/sunrise.png',
            ),
         )
        ]
      ),
    );
  }
}