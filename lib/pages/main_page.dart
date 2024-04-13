import 'package:flutter/material.dart';
import 'package:SkyView/widgets/background.dart';
import 'package:SkyView/widgets/frame/main_frame.dart';
import 'package:SkyView/widgets/topbar.dart';
import 'package:flutter/services.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/widgets/frame/strip.dart';
import 'package:SkyView/widgets/frame/table.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  
  
@override
Widget build(BuildContext context) {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Stack(
      children: [
        const Background(
          height: 1,
          width: 1,
          picture: "assets/images/background_night.jpg",
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.5),
          ),
        ),
        PageView.builder(
          itemCount: AppConstants.cities.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                  Top(
                    width: 1, 
                    height: 0.08, 
                    currentIndex: currentIndex,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  MainFrame(width: 0.7, height: 0.32),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                  StripFarme(width: 0.8, height: 0.06),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                  TableFrame(width: 0.96, height: 0.4),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}
}
