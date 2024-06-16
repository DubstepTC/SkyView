import 'package:SkyView/Appconstants/constants.dart';
import 'package:flutter/material.dart';

class ClothesWidget extends StatelessWidget {
  final int index;
  const ClothesWidget({Key? key, required this.index, }) : super(key: key);

  String clothingRecommendation(int temperature) {
    if (temperature >= -45 && temperature <= -25) {
      return 'Рекомендуется носить теплый пуховик, термобелье и шерстяные носки.';
    } else if (temperature > -25 && temperature <= -18) {
      return 'Рекомендуется теплая куртка, шапка-ушанка и варежки.';
    } else if (temperature > -18 && temperature <= -10) {
      return 'Подойдет зимняя куртка, шерстяной свитер и теплые брюки.';
    } else if (temperature > -10 && temperature <= -2) {
      return 'Хорошим выбором будет ветрозащитная куртка, шапка и перчатки.';
    } else if (temperature > -2 && temperature <= 5) {
    return 'Рекомендуется осенняя куртка, джинсы и свитер.';
    } else if (temperature > 5 && temperature <= 12) {
      return 'Подойдет легкая куртка или ветровка и длинные брюки.';
    } else if (temperature > 12 && temperature <= 19) {
      return 'Комфортно будет в рубашке с длинным рукавом и легких брюках.';
    } else if (temperature > 19 && temperature <= 26) {
      return 'Легкая одежда, например, футболка и шорты, будет уместна.';
    } else if (temperature > 26 && temperature <= 33) {
      return 'Идеально подойдет одежда из легких и дышащих материалов.';
    } else if (temperature > 33 && temperature <= 40) {
      return 'Рекомендуется носить очень легкую и светлую одежду.';
    } else if (temperature > 40 && temperature <= 45) {
      return 'Необходимо носить защитную одежду от солнца и пить много воды.';
    } else {
      return 'Температура вне ожидаемого диапазона.';
    }
  }

  String iconRecommendation(int temperature, String status) {
    if (status == "Дождь" || status == "Небольшой дождь"){
      return "assets/clother/four.png";
    }
    else {
      if (temperature >= -45 && temperature <= -25) {
        return "assets/clother/two.png";
      } else if (temperature > -25 && temperature <= -18) {
        return "assets/clother/two.png";
      } else if (temperature > -18 && temperature <= -10) {
        return "assets/clother/two.png";
      } else if (temperature > -10 && temperature <= -2) {
        return "assets/clother/two.png";
      } else if (temperature > -2 && temperature <= 5) {
      return "assets/clother/three.png";
      } else if (temperature > 5 && temperature <= 12) {
        return "assets/clother/three.png";
      } else if (temperature > 12 && temperature <= 19) {
        return "assets/clother/three.png";
      } else if (temperature > 19 && temperature <= 26) {
        return "assets/clother/one.png";
      } else if (temperature > 26 && temperature <= 33) {
        return "assets/clother/one.png";
      } else if (temperature > 33 && temperature <= 40) {
        return "assets/clother/one.png";
      } else if (temperature > 40 && temperature <= 45) {
        return "assets/clother/one.png";
      } else {
        return "assets/clother/null.png";
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.2,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(39, 64, 87, 0.35),
        border: Border.all(
          color: AppConstants.nightColor, // цвет фиолетовой рамки
          width: 1.0, // толщина рамки
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Текст слева
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  clothingRecommendation(AppConstants.weather[index]["feelslike"]),
                  style: TextStyle(
                    color: AppConstants.nightColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          // Картинка справа
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.34,
            child: Image.asset(
              iconRecommendation(AppConstants.weather[index]["feelslike"], AppConstants.weather[index]["weather_status"]),
            ),
          ),
        ],
      ),
    );
  }
}