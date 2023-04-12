import 'package:flutter/material.dart';
import 'package:frontend/src/views/startupview.dart';

void main() {
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
        appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple)
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}