
class StringN {

  String getWeatherAdvice(String weatherStatus, int temperature) {
    if (temperature < -45 || temperature > 45) {
      return 'Запредельная температура';
    }

    String advice;

    switch (weatherStatus) {
      case 'Снегопад':
        advice = 'Оденьтесь очень тепло, возможно, понадобятся снегоступы.';
        break;
      case 'Дождь':
        advice = 'Не забудьте зонт и непромокаемую одежду!';
        break;
      case 'Пасмурно':
        advice = 'Светлый светоотражающий наряд будет как нельзя кстати.';
        break;
      case 'Ясно':
        advice = 'Наслаждайтесь ясным днем, но не забывайте про солнцезащитные очки.';
        break;
      case 'Солнечно':
        advice = 'Идеальная погода для прогулки, но помните о солнцезащитном креме.';
        break;
      default:
        advice = '';
    }

    if (temperature >= -45 && temperature <= -20) {
      advice += ' Это экстремальный холод, необходимо носить термическое белье и теплую одежду.';
    } else if (temperature > -20 && temperature <= -15) {
      advice += ' Экстремальный холод требует особой осторожности!';
    } else if (temperature > -15 && temperature <= -6) {
      advice += ' Не забудьте шапку и перчатки.';
    } else if (temperature > -6 && temperature <= 3) {
      advice += ' Время достать теплые куртки.';
    } else if (temperature > 3 && temperature <= 9) {
      advice += ' Хорошая погода для легкой куртки.';
    } else if (temperature > 9 && temperature <= 16) {
      advice += ' Идеально для кардигана или свитера.';
    } else if (temperature > 16 && temperature <= 24) {
      advice += ' Легкая одежда будет самым лучшим выбором.';
    } else if (temperature > 24 && temperature <= 35) {
      advice += ' Жарко! Лучше носить шорты и футболки.';
    } else if (temperature > 35 && temperature <= 45) {
      advice += ' Очень жарко! Не забывайте пить много воды и оставаться в тени.';
    }

    return advice;
  }

 }