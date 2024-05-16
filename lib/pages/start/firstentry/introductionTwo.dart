import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/function/animation.dart';
import 'package:SkyView/pages/start/firstentry/introductionThree.dart';
import 'package:SkyView/pages/start/firstentry/introductionTwo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class IntroductionTwo extends StatefulWidget {
  @override
  _IntroductionTwoState createState() => _IntroductionTwoState();
}

class _IntroductionTwoState extends State<IntroductionTwo> {

  @override
  Widget build(BuildContext context){

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return Scaffold(
      body: SizedBox(
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
                  height: MediaQuery.of(context).size.height * 0.08,
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
                Stack(
                  children: [ 
                    Column(children: [
                    SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.59,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage("assets/intro/screen_five.jpg"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 80,),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.59,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage("assets/intro/screen_six.jpg"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ],),
                    Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.64,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage("assets/intro/screen_four.jpg"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,)
                      ],
                    ),
                    ],)
                  ]
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.26,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const Text(
                    "Подробная информация о текущем дне доступна для просмотра. Вы можете проверить давление, влажность, вероятность осадков, время заката и восхода, а также почасовой прогноз на 24 часа.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(194, 184, 255, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        AnimatedTransition(enterPage: IntroductionThree()),
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
      ),
    );
  }
}
