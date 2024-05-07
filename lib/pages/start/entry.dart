import 'package:flutter/material.dart';

class Entry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(185, 130, 198, 1.0),
                  Color.fromRGBO(145, 102, 182, 1.0),
                ],
              ),
            ),
          ),
          // Изображение загрузчика
          Center(
            child: Container(
              height: MediaQuery.of(context).size.width * 0.6,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/loader.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
