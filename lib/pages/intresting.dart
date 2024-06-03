import 'package:SkyView/pages/main_page.dart';
import 'package:SkyView/widgets/clothes.dart';
import 'package:SkyView/widgets/leisure.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SkyView/Appconstants/constants.dart';

class Intresting extends StatefulWidget {
  final int currentIndex;

  const Intresting({Key? key, required this.currentIndex}) : super(key: key);

  @override
  _IntrestingState createState() => _IntrestingState();
}

class _IntrestingState extends State<Intresting> {
  late int currentIndex = widget.currentIndex;

  final List<Map<String, dynamic>> myList = [
    {
      'status': 'Дождь',
      'text': 'Приготовление вкусных блюд',
      'icons': 'assets/leisure/eight.png',
      'options': 'Это отличное время для того, чтобы устроить кулинарный марафон и попробовать новые рецепты. Приготовьте суп, рагу, пироги или другие угощения и наслаждайтесь ароматами и вкусами.',
    },
    {
      'status': 'Дождь',
      'text': 'Чтение книги',
      'icons': 'assets/leisure/nine.png',
      'options': 'Заварите чашечку горячего чая, укройтесь одеялом и погрузитесь в увлекательный мир книги. Это отличный способ провести время и расслабиться.',
    },
    {
      'status': 'Дождь',
      'text': 'Просмотр фильмов или сериалов',
      'icons': 'assets/leisure/six.png',
      'options': 'Создайте уютный кинотеатр у себя дома, выберите фильм или сериал, который давно хотели посмотреть, и наслаждайтесь просмотром.',
    },
    {
      'status': 'Дождь',
      'text': 'Занятия йогой или медитацией',
      'icons': 'assets/leisure/ten.png',
      'options': 'Используйте дождливую погоду для занятий йогой или медитацией. Это поможет вам расслабиться, снять стресс и сосредоточиться.',
    },
    {
      'status': 'Холодно',
      'text': 'Приготовление горячих напитков',
      'icons': 'assets/leisure/three.png',
      'options': 'Заварите ароматный чай, горячий какао или кофе, наслаждайтесь их ароматом и теплом. Можно попробовать новые рецепты или добавить необычные специи для разнообразия.',
    },
    {
      'status': 'Холодно',
      'text': 'Чтение книг',
      'icons': 'assets/leisure/nine.png',
      'options': 'Заварите чашечку горячего чая, укройтесь одеялом и погрузитесь в увлекательный мир книги. Это отличный способ провести время и расслабиться.',
    },
    {
      'status': 'Холодно',
      'text': 'Занятия рукоделием',
      'icons': 'assets/leisure/four.png',
      'options': 'Рукоделие - прекрасный способ проявить свою творческую натуру в холодную погоду. Вы можете вязать, шить, лепить, делать бижутерию и многое другое.',
    },
    {
      'status': 'Холодно',
      'text': 'Просмотр фильмов или сериалов',
      'icons': 'assets/leisure/six.png',
      'options': 'Создайте уютный кинотеатр у себя дома, выберите фильм или сериал, который давно хотели посмотреть, и наслаждайтесь просмотром.',
    },
    {
      'status': 'Жарко',
      'text': 'Пикник на свежем воздухе',
      'icons': 'assets/leisure/eleven.png',
      'options': 'Организуйте пикник в парке или лесу. Приготовьте вкусные закуски, прохладные напитки, возьмите плед и наслаждайтесь природой.',
    },
    {
      'status': 'Жарко',
      'text': 'Велопрогулки',
      'icons': 'assets/leisure/seven.png',
      'options': 'Покатайтесь на велосипеде по живописным местам. Это отличный способ исследовать окрестности, насладиться природой и получить заряд энергии.',
    },
    {
      'status': 'Жарко',
      'text': 'Бассейн или аквапарк',
      'icons': 'assets/leisure/twelve.png',
      'options': 'Посетите бассейн или аквапарк, чтобы освежиться и поплавать в прохладной воде. Это замечательный способ провести время и остаться в форме.',
    },
    {
      'status': 'Жарко',
      'text': 'Занятие медитацией',
      'icons': 'assets/leisure/ten.png',
      'options': 'Используйте дождливую погоду для занятий йогой или медитацией. Это поможет вам расслабиться, снять стресс и сосредоточиться.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    String st = "";

    if (
      AppConstants.weather[currentIndex]["feelslike"] >= 12 && 
      AppConstants.weather[currentIndex]["weather_status"] != "Дождь" && 
      AppConstants.weather[currentIndex]["weather_status"] != "Небольшой дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Мелкий дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами дождь со снегом" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами замерзающая морось" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами слабая морось" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Слабая морось" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Замерзающая морось" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Сильная замерзающая морось" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами небольшой дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Временами умеренный дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Умеренный дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Временами сильный дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Сильный дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Сильные ливни" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Небольшой ледяной дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Небольшой ливневый дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Ледяной дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Снег" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами снег" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Поземок" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Метель" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами небольшой снег" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Небольшой снег" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами умеренный снег" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Умеренный снег" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами сильный снег" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Сильный снег" && 
      AppConstants.weather[currentIndex]["weather_status"] != "Умеренный или сильный снег"
    ){
      st = "Холодно";
    }
    else if (
      AppConstants.weather[currentIndex]["feelslike"] >= 12 && 
      AppConstants.weather[currentIndex]["weather_status"] != "Дождь" && 
      AppConstants.weather[currentIndex]["weather_status"] != "Небольшой дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Мелкий дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами дождь со снегом" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами замерзающая морось" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами слабая морось" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Слабая морось" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Замерзающая морось" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Сильная замерзающая морось" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами небольшой дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Временами умеренный дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Умеренный дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Временами сильный дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Сильный дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Сильные ливни" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Небольшой ледяной дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Небольшой ливневый дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Ледяной дождь" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Снег" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами снег" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Поземок" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Метель" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами небольшой снег" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Небольшой снег" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами умеренный снег" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Умеренный снег" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Местами сильный снег" &&
      AppConstants.weather[currentIndex]["weather_status"] != "Сильный снег" && 
      AppConstants.weather[currentIndex]["weather_status"] != "Умеренный или сильный снег"
    ) {
      st = "Жарко";
    }
    else {
      st = "Дождь";
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(currentIndex: widget.currentIndex,)));            
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background_inter.jpg"),
                  fit: BoxFit.cover,
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
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(currentIndex: widget.currentIndex,)));            
                              setState(() {});
                            },
                            child: ColorFiltered(
                              colorFilter: const ColorFilter.mode( Color.fromARGB(255, 255, 255, 255), BlendMode.modulate),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.height,
                                child: Image.asset("assets/images/arrow.png"),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: const Text(
                              "Дополнительная информация",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Text(
                      "Совет по одежде",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ClothesWidget(index: currentIndex),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Text(
                      "Пару идей чем можно заняться",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.48,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ListView.builder(
                      itemCount: myList.where((item) => item['status'] == st).length,
                      itemBuilder: (context, index) {
                        var filteredList = myList.where((item) => item['status'] == st).toList();
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10), // Отступ равный 10
                          child: Container(// Ширина 80% от ширины экрана
                            child: LeisureWidget(
                              index: index,
                              txt: filteredList[index]['text'],
                              image: filteredList[index]['icons'],
                              options: filteredList[index]['options'],
                            ),
                          ),
                        ); 
                      },
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
