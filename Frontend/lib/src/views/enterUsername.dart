import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/views/homeview.dart';

class UsernameInput extends StatefulWidget {
  const UsernameInput({Key? key}) : super(key: key);

  @override
  _UsernameInputState createState() => _UsernameInputState();
}

class _UsernameInputState extends State<UsernameInput> {
  bool _showText = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showText = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _showText ? 1.0 : 0.0,
          child: const Text(
            "Enter your username:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const TextField(
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
