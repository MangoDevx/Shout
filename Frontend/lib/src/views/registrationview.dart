import 'package:flutter/material.dart';
import 'package:frontend/src/controllers/startupcontroller.dart';
import 'package:frontend/src/views/loginview.dart';

class RegistrationScreen extends StatelessWidget {
  /* This widget is a splash screen which should check for the basic
     permissions needed for the application. If any permissions are missing,
     the user should be prompted to accept the permissions.
  */

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
