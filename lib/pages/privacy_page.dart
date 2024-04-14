import 'package:flutter/material.dart';
import 'package:SkyView/widgets/background.dart';
import 'package:flutter/services.dart';

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {   
  
@override
Widget build(BuildContext context) {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Вычисляем ширину прямоугольника
    double screenWidth = MediaQuery.of(context).size.width;
    // Вычисляем высоту прямоугольника
    double screenHeight = MediaQuery.of(context).size.height;
  
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Stack(
      children: [
        const Background(
          height: 1,
          width: 1,
          picture: "assets/images/policy.jpg",
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.5),
          ),
        ),
        SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.04,),
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: screenWidth * 0.05,),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(const Color.fromARGB(255, 255, 255, 255), BlendMode.modulate), // Замените Colors.red на нужный вам цвет
                        child: SizedBox(
                          width: screenWidth * 0.10,
                          height: screenHeight,
                          child: Image.asset("assets/images/arrow.png"),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.12,),
                    const Text(
                      "Политика",
                      style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: screenWidth * 0.25,),
                  ]
                ),
              ),  
              Container(
                width: screenWidth * 0.95,
                height: screenHeight * 0.80,
                padding: const EdgeInsets.all(16.0),
                child: const SingleChildScrollView(
                  child: Text(
                    "     Ваша конфиденциальность имеет для нас высокое значение. В данном заявлении о политике конфиденциальности описывается, как мы собираем, используем и защищаем вашу личную информацию в процессе использования нашего приложения для просмотра погоды.\n\n"
                    "1. Сбор информации\n\n"
                    "     Мы автоматически собираем определенную информацию, когда вы используете наше приложение для просмотра погоды, включая данные о вашем устройстве, такие как модель, версия операционной системы, уникальный идентификатор устройства и информацию о сети.\n\n"
                    "2. Использование информации\n\n"
                    "     Собранная информация используется исключительно для улучшения качества нашего приложения и предоставления вам более точных прогнозов погоды. Мы также можем использовать эту информацию для анализа тенденций использования и улучшения пользовательского опыта.\n\n"
                    "3. Обмен информацией\n\n"
                    "     Мы не передаем вашу личную информацию третьим лицам без вашего согласия, за исключением случаев, когда это необходимо для обеспечения работы приложения или соблюдения законных требований.\n\n"
                    "4. Безопасность данных\n\n"
                    "     Мы принимаем все необходимые меры для защиты вашей личной информации от несанкционированного доступа, изменения или раскрытия. Мы используем современные методы шифрования данных и строго соблюдаем политики безопасности.\n\n"
                    "5. Доступ и контроль\n\n"
                    "     Вы можете управлять настройками конфиденциальности вашего устройства, чтобы ограничить сбор определенной информации нашим приложением. Вы также можете обратиться к нам с запросом на удаление вашей личной информации из наших систем.\n\n"
                    "6. Согласие\n\n"
                    "     Используя наше приложение для просмотра погоды, вы соглашаетесь с условиями нашей политики конфиденциальности. Пожалуйста, внимательно ознакомьтесь с этим документом перед использованием приложения.\n\n"
                    "7. Обновления политики конфиденциальности\n\n"
                    "     Мы оставляем за собой право периодически обновлять нашу политику конфиденциальности. Любые изменения будут опубликованы на этой странице, и вы будете уведомлены о них при следующем входе в приложение. Если у вас возникли вопросы или замечания относительно нашей политики конфиденциальности, пожалуйста, свяжитесь с нами по адресу [контактная информация].\n\n"
                    "           С уважением, Команда SkyView",
                    style: TextStyle(
                      color: Color.fromRGBO(194, 184, 255, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),   
            ],
          ),
        ),
      ]
    ),
  );
}
}
