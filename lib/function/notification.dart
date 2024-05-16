import 'package:SkyView/Appconstants/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Notifications(this.flutterLocalNotificationsPlugin);

  // Initialize notifications channel
  AndroidNotificationChannel channel =  AndroidNotificationChannel(
    'your_channel_id',
    'Channel name',
    ledColor: AppConstants.nightColor,
    importance: Importance.high,
  );

  void initializeNotifications() {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('drawable/s');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification({
    required String title,
    required String message, // Добавьте этот параметр для динамического текста
  }) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      message,
      contentTitle: title, // Это можно сделать динамическим, если нужно
      summaryText: 'Подробнее...',
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "SKYVIEW",
      "Sky",// Добавлено описание канала
      styleInformation: bigTextStyleInformation,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      platformChannelSpecifics,
      payload: 'your_payload',
    );
  }

}