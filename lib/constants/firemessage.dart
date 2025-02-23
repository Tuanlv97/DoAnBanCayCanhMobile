// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.max,
);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);

const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin, macOS: initializationSettingsDarwin);

Future onDidReceiveLocalNotification(int? id, String? title, String? body, String? payload) async {
  print('title');
  print('payload');
}

class FireMessage {
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message");
    // handleData(message);

    print('Handling a background message ${message.messageId}');
  }
  static var firebaseCloudMessaging = FirebaseMessaging.instance;
  static Future<void> registerFirebase() async {
    var settings = await firebaseCloudMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onBackgroundMessage(FireMessage.firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((message) {
      handleDataInApp(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleData(message);
    });
    checkOpenAppFromTerminate();
  }

  static Future<void> registerToken() async {
    try {
      if (Platform.isIOS) {
        await firebaseCloudMessaging.requestPermission(provisional: true);
      } else {}
      await firebaseCloudMessaging.getToken().then((token) async {
        print("token firebase $token");
       
      });
    } catch (e) {
      print(e);
    }
  }

  static void removeToken(String? id) async {
    await firebaseCloudMessaging.getToken().then((value) async {});
  }

  static void checkOpenAppFromTerminate() async {
    var initialMessage = await firebaseCloudMessaging.getInitialMessage();
    print('terminal ${jsonEncode(initialMessage?.data ?? {})}');
    print('terminal1 ${jsonEncode(initialMessage.toString())}');
    if (initialMessage != null) {
     await Future.delayed(const Duration(seconds: 3));
     
      handleData(initialMessage);
      return;
    }
  }

  static void onDidReceiveNotificationResponse(NotificationResponse details) async {
    if (details.payload != null) {}
  }

  static void notificationTapBackground(NotificationResponse details) {
    print("abc: ${details.notificationResponseType}");
  }

  static void handleData(
    RemoteMessage message,
  ) async {
    print("message messs ${message.data}");
   
  }

  static void handleDataInApp(RemoteMessage message) async {
    print("message ${message.data}");
   
  }

  static Future<void> addBadge(int number) async {
    await FlutterAppBadger.updateBadgeCount(number);
  }

}

enum TypeNotification { startLiveStream, sendMessagePrivate, sendVoicePrivate, none }

extension StringToTypeNotification on String {
  TypeNotification toTypeNotification() {
    switch (this) {
      case "start_live_stream":
        return TypeNotification.startLiveStream;
      case "send_message_private":
        return TypeNotification.sendMessagePrivate;
      case "send_voice_private":
        return TypeNotification.sendVoicePrivate;
      default:
        return TypeNotification.none;
    }
  }
}
