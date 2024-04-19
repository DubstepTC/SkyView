import 'package:SkyView/Appconstants/constants.dart';
import 'package:flutter/material.dart';

class DeleteCity {
void showAddCityDialog(BuildContext context, String city, String country) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(39, 64, 87, 1),
          contentTextStyle: TextStyle(fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.bold), 
          content: Text("Удалить город из списка?", textAlign: TextAlign.center,),
          actions: [
            SizedBox(width: 10,),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Нет", style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 60,),
            TextButton(
              onPressed: () {
                if (AppConstants.cityCountryMap.containsKey(city)) {
                  // Если город уже существует в мапе, ничего не делаем
                  AppConstants.cityCountryMap.remove(city);
                } else {
                  // Если города нет в мапе, добавляем его с указанием страны;
                }
                Navigator.of(context).pop();
              },
              child: Text("Да", style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 20,),
          ],
        );
      },
    );
  }
}