import 'package:flutter/material.dart';
import 'package:SkyView/widgets/background.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                child: const Background(
                  height: 1,
                  width: 1,
                  picture: "assets/images/background_rain.jpg",),
              )
            )
          ]
          ),
      ),
    );
  }
}