import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Notifications(this.flutterLocalNotificationsPlugin);

  // Initialize notifications channel
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'your_channel_id',
    'Channel name',
    importance: Importance.high,
  );

  void initializeNotifications() {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> showNotification({required String title, required String message}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      platformChannelSpecifics,
      payload: 'your_payload',
    );
  }
}