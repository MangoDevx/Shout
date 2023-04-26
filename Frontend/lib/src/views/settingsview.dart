import 'package:flutter/material.dart';
import 'package:frontend/src/controllers/startupcontroller.dart';
import 'package:frontend/src/views/loginview.dart';
import 'package:frontend/src/views/nolocationview.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
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
