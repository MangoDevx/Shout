import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/views/startupview.dart';
import 'package:google_api_availability/google_api_availability.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GoogleApiAvailability.instance.makeGooglePlayServicesAvailable();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  var token = await FirebaseMessaging.instance.getToken();
  log(token ?? 'null');
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  await FirebaseMessaging.instance.subscribeToTopic("shout");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shout!',
      theme: ThemeData(
          backgroundColor: Colors.white,
          primarySwatch: Colors.deepPurple,
          primaryColor: Colors.deepPurple,
          primaryColorDark: Colors.black,
          primaryColorLight: const Color(0xfff5f5f5),
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple)),
      //debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}