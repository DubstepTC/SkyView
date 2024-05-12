import 'package:SkyView/Appconstants/constants.dart';

class Pressuretranslation {
    
    String temp = AppConstants.pressure;

    Future updateList() async {

    for (int i = 0; i < AppConstants.weather.length; i ++){

        double pr = double.parse(AppConstants.weather[i]["pressure_mb"].toString());
        if (AppConstants.pressure == "Миллиметр ртутного столба (мм рт. ст)" && temp != AppConstants.pressure){
          AppConstants.hours[i]["pressure_mb"] = AppConstants.weather[i]["pressure_mb"];  
        }
        else if (AppConstants.pressure == "Физическая атмосфера (атм)" && temp != AppConstants.pressure ) { 
          AppConstants.hours[i]["pressure_mb"] = double.parse((pr / 760).toStringAsFixed(2));
        }
        else if (AppConstants.pressure == "Миллибар (мбар)" && temp != AppConstants.pressure ) { 
          AppConstants.hours[i]["pressure_mb"] = double.parse((pr * 1.33322).toStringAsFixed(2));
        }
    }
  }
}