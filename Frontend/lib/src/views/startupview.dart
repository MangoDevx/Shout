import 'package:flutter/material.dart';
import 'package:frontend/src/controllers/startupcontroller.dart';
import 'package:frontend/src/views/loginview.dart';
import 'package:frontend/src/views/nolocationview.dart';
import 'package:google_api_availability/google_api_availability.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  /* This widget is a splash screen which should check for the basic
     permissions needed for the application. If any permissions are missing,
     the user should be prompted to accept the permissions.
  */

  @override
  initState() {
    super.initState();
    var screen = const LoginScreen();

    Future.delayed(
        const Duration(seconds: 3),
        () async => {
              if (await requestPermissions(context))
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => screen),
                  )
                }
              else
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NoLocationScreen()),
                  )
                },
            });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        child: const DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
          image: AssetImage('assets/shouttplogo.png'),
          scale: 2,
        ))));
  }
}
