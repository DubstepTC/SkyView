import 'package:SkyView/Appconstants/constants.dart';
import 'package:flutter/material.dart';

class CustomContainerWidget extends StatefulWidget {
  final double width;
  final double height;
  final String nameContainer;
  final List<String> choice;
  final String con;

  CustomContainerWidget({super.key, required this.nameContainer, required this.choice, required this.con, required this.height, required this.width});
  @override
  
  _CustomContainerWidgetState createState() => _CustomContainerWidgetState();
}

class _CustomContainerWidgetState extends State<CustomContainerWidget> {
  late String _selectedOption;

  @override
  void initState() {
    super.initState();
      if (widget.con == 'temperature') {
        _selectedOption = AppConstants.temperature;
      } else if (widget.con == 'windSpeeed') {
        _selectedOption = AppConstants.windSpeeed;
      } else if (widget.con == 'pressure'){
        _selectedOption = AppConstants.pressure;
      } else {
        _selectedOption = widget.choice[0];
      }
  }

  void _showOptionsDialog(BuildContext context, List<String> options, String globalVariable) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color.fromRGBO(39, 64, 87, 1),
        contentTextStyle: TextStyle(fontSize: 16.0, color: Colors.white), 
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            bool isSelected = _selectedOption == option;
            return ListTile(
              title: isSelected ? Text(option, style: TextStyle(fontSize: 16.0, color: Color.fromRGBO(194, 184, 255, 1)),) : Text(option, style: TextStyle(fontSize: 16.0, color: Colors.white)),
              trailing: isSelected ? Icon(Icons.check, color: Color.fromRGBO(194, 184, 255, 1),) : null, 
              onTap: () {
                setState(() {
                  _selectedOption = option;
                });
                Navigator.pop(context);
                if (globalVariable == 'temperature') {
                  AppConstants.temperature = option;
                  AppConstants.savePreferences();
                } else if (globalVariable == 'windSpeeed') {
                  AppConstants.windSpeeed = option;
                  AppConstants.savePreferences();
                } else {
                  AppConstants.pressure = option;
                  AppConstants.savePreferences();
                }
              },
            );
          }).toList(),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * widget.width; 
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * widget.height;

    return GestureDetector(
      onTap: () {
        _showOptionsDialog(context, widget.choice, widget.con);
      },
      child: Container(
        height: rectangleHeight,
        width: rectangleWidth,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Text(
                widget.nameContainer,
                textAlign: TextAlign.start,
                style: const TextStyle(color: Color.fromRGBO(194, 184, 255, 1), fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(width: screenWidth * 0.1,),
            Expanded(
              flex: 4,
              child: 
                  Text(
                    _selectedOption,
                    textAlign: TextAlign.end, 
                    style: const TextStyle(color: Color.fromRGBO(194, 184, 255, 1), fontSize: 16, fontWeight: FontWeight.normal),
                  ),
            ),
            Expanded(
              flex: 1,
              child: Transform.rotate(
                angle: 1.5708, // Угол поворота в радианах (90 градусов)
                child: const Text(
                  "<>",
                  style: TextStyle(
                    color: Color.fromRGBO(194, 184, 255, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
