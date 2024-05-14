import 'package:SkyView/pages/addcity.dart';
import 'package:flutter/material.dart';
import 'package:SkyView/Appconstants/constants.dart'; // Замените на имя вашего файла с экраном результатов поиска

class SearchContainerWidget extends StatefulWidget {
  final double width;
  final double height;

  SearchContainerWidget({required this.width, required this.height});

   @override
    _SearchContainerWidgetState createState() => _SearchContainerWidgetState();
  }

  class _SearchContainerWidgetState extends State<SearchContainerWidget> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * widget.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * widget.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchResultsScreen(currentIndex: 0,)),
        );
      },
      child: Container(
        width: rectangleWidth,
        height: rectangleHeight,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: AppConstants.backColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Text(
                'Введите местоположение',
                style: TextStyle(
                  color: AppConstants.nightColor,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.white,),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchResultsScreen(currentIndex: 0)));
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
