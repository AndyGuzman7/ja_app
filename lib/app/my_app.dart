import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_meedu/ui.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ja_app/app/ui/routes/app_routes.dart';
import 'package:ja_app/app/ui/routes/routes.dart';
import 'package:ja_app/app/utils/MyColors.dart';
import 'package:ja_app/src/providers/push_notifications_provider.dart';
/*
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title

    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}
*/
/*void showNotification() {
  flutterLocalNotificationsPlugin.show(
    0,
    "Testing",
    "How you doin ?",
    NotificationDetails(
      android: AndroidNotificationDetails(channel.id, channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          color: Colors.blue,
          playSound: true,
          icon: '@mipmap/ic_launcher'),
    ),
  );
}*/

void suscribeHotel() async {
  FirebaseMessaging.instance.subscribeToTopic("notificationData").then(
        (value) => print("subscrito"),
      );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    suscribeHotel();
    /*PushNotificationService.messageStream.listen((message) {
      log("My app");

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        log("siu");
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });*/
    /*FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Blog App",
      theme: ThemeData(
        //brightness: Brightness.light,

        textTheme: GoogleFonts.ubuntuTextTheme(),
        primarySwatch: CustomColorPrimary().materialColor,
      ),
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''), // arabic, no country code
      ],
      navigatorKey: router.navigatorKey,
      initialRoute: Routes.SPLASH,
      routes: appRoutes,
      navigatorObservers: [router.observer],
      debugShowCheckedModeBanner: false,
      //home: HomePage(),
    );
  }
}
