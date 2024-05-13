import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/pages/start/firstentry/definitioncity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class IntroductionOne extends StatefulWidget {
  @override
  _IntroductionOneState createState() => _IntroductionOneState();
}

class _IntroductionOneState extends State<IntroductionOne> {

  void _setWelcomeFlag() async {
    AppConstants.welcome = "true";
    AppConstants.savePreferences();
  }

  @override
  Widget build(BuildContext context){

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/loader.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.7),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Text(
                  "SkyView",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(194, 184, 255, 1),
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.8,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/intro/one.jpg"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.8,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/intro/screen_six.jpg"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.22,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Text(
                  "Приложение, которое поможет вам отслеживать метеорологические прогнозы, представляет собой удобный инструмент для планирования своих действий в зависимости от текущей и предстоящей погоды.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(194, 184, 255, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    _setWelcomeFlag();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DefinitionCity()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, 
                    backgroundColor: const Color.fromRGBO(194, 184, 255, 1),
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.4, MediaQuery.of(context).size.height * 0.07)
                  ),
                  child: const Text(
                    'Далее',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
