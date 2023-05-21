import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:taskapp/models/Task.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class NotifyHelper {
  FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); 

  initializeNotification() async {
    //tz.initializeTimeZones();
    _configureLocalTimezone();
   // this is for latest iOS settings
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );

 final AndroidInitializationSettings initializationSettingsAndroid =
     const AndroidInitializationSettings("appicon");

final InitializationSettings initializationSettings =
        InitializationSettings(
       iOS: initializationSettingsIOS,
       android:initializationSettingsAndroid,
    );
   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
   onSelectNotification: selectNotification
   );
  }
  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
         iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default notificationsound',
    );
  }
  scheduledNotification(int hour, int minutes, Task task) async {
    int newTime =minutes;
     await flutterLocalNotificationsPlugin.zonedSchedule(
         task.id!.toInt(),
         task.title,
         task.note,
         _convertTime(hour , minutes),
         //tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
         const NotificationDetails(
             android: AndroidNotificationDetails('your channel id',
                 'your channel name',)),
         androidAllowWhileIdle: true,
         uiLocalNotificationDateInterpretation:
             UILocalNotificationDateInterpretation.absoluteTime,
             
             matchDateTimeComponents:DateTimeComponents.time 
             
             
             );

        


   }

  tz.TZDateTime _convertTime(int hour, int minutes){
    final tz.TZDateTime now =tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
      tz.TZDateTime(tz.local, now.year, now.month,now.day, hour, minutes);
      if (scheduleDate.isBefore(now)) {
        scheduleDate =scheduleDate.add(const Duration(days: 1));
        
      }
      return scheduleDate;
  }


  Future <void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timezone =await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezone));

  }




   void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
   Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
     Get.to(()=>Container(color: Colors.white,));
  }



   Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    Get.dialog(const Text("Welcome"));
      }

  
}