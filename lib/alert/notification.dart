import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationsService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('bell');

  void initializaNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification(int id, String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }

  void scheduleNotification(int id, String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    RepeatInterval repeat;

    if (id == 1) {
      repeat = RepeatInterval.hourly;
    } else if (id == 2) {
      repeat = RepeatInterval.hourly;
    } else if (id == 3) {
      repeat = RepeatInterval.daily;
    } else {
      repeat = RepeatInterval.everyMinute;
    }

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      repeat,
      notificationDetails,
    );
  }

  void cancelNotification() async {
    _flutterLocalNotificationsPlugin.cancelAll();
  }

  void customizeNotification(
      {int? id, String? body, tz.TZDateTime? scheduledDate}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id!,
      'Remainder',
      body,
      scheduledDate!,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
