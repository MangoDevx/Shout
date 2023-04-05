import 'package:flutter/material.dart';
import 'package:frontend/src/controllers/startupcontroller.dart';
import 'package:frontend/src/views/loginview.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  /* This widget is a splash screen which should check for the basic
     permissions needed for the application. If any permissions are missing,
     the user should be prompted to accept the permissions.
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: page(),
    );
  }

  Widget page() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(children: []),
      ),
    );
  }
}
