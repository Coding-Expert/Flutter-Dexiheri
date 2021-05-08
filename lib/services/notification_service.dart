
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static showNotification(int id, String title, String date) async {
    var android = new AndroidNotificationDetails(
        id.toString(), id.toString(), id.toString(),
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        id, title, date, platform,
        payload: 'welcome to event notification');
  }

}