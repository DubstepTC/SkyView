import 'package:SkyView/function/background.dart';
import 'package:SkyView/function/notification.dart';
import 'package:SkyView/function/string_n.dart';
import 'package:SkyView/widgets/clothes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SkyView/Appconstants/constants.dart';
import 'package:SkyView/widgets/frame/main_frame.dart';
import 'package:SkyView/widgets/frame/strip.dart';
import 'package:SkyView/widgets/frame/table.dart';
import 'package:SkyView/widgets/main/emty.dart';
import 'package:SkyView/widgets/main/topbar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MainScreen extends StatefulWidget {
  final int currentIndex;

  const MainScreen({Key? key, required this.currentIndex}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  late int index = widget.currentIndex;
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.currentIndex);
    _pageController.addListener(() {
      setState(() {
        opacity = 0.5;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    // Создайте экземпляр класса Notifications
  Notifications notifications = Notifications(FlutterLocalNotificationsPlugin());
  StringN str = StringN();
  // Инициализируйте настройки уведомлений
  notifications.initializeNotifications();

    DateTime now = DateTime.now();
    String day = now.year.toString() + "-" + now.month.toString() + "-" + now.day.toString();
    if (AppConstants.day != day)
    {
      // Вызовите showNotification 
      notifications.showNotification(
        title: 'Совет дня',
        message: str.getWeatherAdvice(AppConstants.weather[0]["weather_status"], AppConstants.weather[0]["temperature"]),
      );
      AppConstants.day = day;
    }
    AppConstants.savePreferences();
    
    

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        SystemNavigator.pop(animated: true);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(194, 184, 255, 1.0),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppConstants.weather.isEmpty ? "assets/images/background_night.jpg" : BackgroundHelper().buildWeatherImage(AppConstants.weather[index]["weather_status"]),
                  ),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  scale: opacity * 0.5 + 1,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ),
            PageView.builder(
              controller: _pageController,
              itemCount: AppConstants.cityCountryMap.isNotEmpty
                  ? AppConstants.cityCountryMap.length
                  : 1,
              onPageChanged: (pageIndex) {
                setState(() {
                  index = pageIndex;
                });
              },
              itemBuilder: (context, index) {
                if (AppConstants.cityCountryMap.isNotEmpty) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.bounceIn,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Top(
                          width: 1,
                          height: 0.08,
                          currentIndex: index,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        MainFrame(
                          width: 0.7,
                          height: 0.32,
                          currentIndex: index,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        StripFarme(
                          width: 0.9,
                          height: 0.06,
                          currentIndex: index,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        TableFrame(
                          width: 0.96,
                          height: 0.4,
                          currentIndex: index,
                        ),
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        EmptyTop(
                          width: 1,
                          height: 0.08,
                          currentIndex: index,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.32,
                        ),
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
      ),
    );
  }
}
