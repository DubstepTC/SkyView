import 'package:SkyView/widgets/main/emty.dart';
import 'package:flutter/material.dart';
import 'package:SkyView/widgets/background.dart';
import 'package:SkyView/widgets/frame/main_frame.dart';
import 'package:SkyView/widgets/main/topbar.dart';
import 'package:flutter/services.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/widgets/frame/strip.dart';
import 'package:SkyView/widgets/frame/table.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required int currentIndex});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    setState(() {});
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
            itemCount: AppConstants.cityCountryMap.isNotEmpty
                ? AppConstants.cityCountryMap.length
                : 1, // Display another screen if the list is empty
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              if (AppConstants.cityCountryMap.isNotEmpty) {
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
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                      EmptyTop(
                        width: 1, 
                        height: 0.08, 
                        currentIndex: currentIndex,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.32,),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: MediaQuery.of(context).size.height * 0.56,
                        padding: const EdgeInsets.all(16.0),
                        child: const SingleChildScrollView(
                          child: Text(
                            "Добавьте город для отображения погоды",
                            style: TextStyle(
                              color: Color.fromRGBO(194, 184, 255, 1),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
