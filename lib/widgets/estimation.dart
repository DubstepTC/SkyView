import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Estimation extends StatelessWidget {
  final double width;
  final double height;

  Estimation({super.key, required this.width, required this.height,});

  void _showRatingDialog(BuildContext context) {
    double rating = 3;
    showDialog(
      context: context,
      barrierDismissible: true, 
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(39, 64, 87, 1),
          title: const Text('Оценика', textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(194, 184, 255, 1), fontSize: 18,),),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Color.fromRGBO(194, 184, 255, 1),
                ), 
                onRatingUpdate: (newRating) {
                  setState(() {
                    rating = newRating;
                    Future.delayed(Duration(milliseconds: 500), () {
                      Navigator.of(context).pop();
                    });
                  });
                },
              );
            },
          ),
        );
      },
    );
  }

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
        _showRatingDialog(context);
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
                'Обратная связь',
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