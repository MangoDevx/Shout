import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple)
      ),
      home: SplashScreen(),
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  /* This widget is a splash screen which should check for the basic
     permissions needed for the application. If any permissions are missing,
     the user should be prompted to accept the permissions.
  */
  
  @override initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async => { /* request permissions here */ });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: const DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/shouttplogo.png'),
            scale: 2,
          )
        )
      )
    );
  }

}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}


Future _requestPermissions(BuildContext context) async {
 // Request needed permissions
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.notification,
  ].request();

  // If location is disabled display an error
  if (await Permission.location.isDenied) {
    // Error page
  }

  // If location is enabled go to login screen
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );
}