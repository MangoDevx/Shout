import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NoLocationScreen extends StatefulWidget {
  const NoLocationScreen({super.key});

  @override
  State<NoLocationScreen> createState() => _NoLocationScreenState();
}

class _NoLocationScreenState extends State<NoLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Location services must be enabled to use our app.',
                    style: TextStyle(color: Colors.red),
                  ),
                ]),
          ),
        ));
  }
}
