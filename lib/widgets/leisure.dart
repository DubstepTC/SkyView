import 'package:SkyView/Appconstants/constants.dart';
import 'package:flutter/material.dart';

class LeisureWidget extends StatelessWidget {
  final int index;
  final String txt;
  final String image;
  final String options;
  const LeisureWidget({Key? key, required this.index, required this.txt, required this.image, required this.options, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
                  txt,
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
              image
            ),
          ),
        ],
      ),
    );
  }
}