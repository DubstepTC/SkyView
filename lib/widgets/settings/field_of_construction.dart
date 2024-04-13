import 'package:flutter/material.dart';

class CustomContainerWidget extends StatefulWidget {
  final String nameContainer;
  final String choice;

  CustomContainerWidget({super.key,  required this.nameContainer, required this.choice});
  @override
  
  _CustomContainerWidgetState createState() => _CustomContainerWidgetState();
}

class _CustomContainerWidgetState extends State<CustomContainerWidget> {
  String _selectedOption = 'Option 1';

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Option 1'),
                onTap: () {
                  setState(() {
                    _selectedOption = 'Option 1';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Option 2'),
                onTap: () {
                  setState(() {
                    _selectedOption = 'Option 2';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Option 3',),
                onTap: () {
                  setState(() {
                    _selectedOption = 'Option 3';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showOptionsDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.nameContainer,
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.normal),
              ),
            ),
            Text(_selectedOption, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.normal),),
          ],
        ),
      ),
    );
  }
}
