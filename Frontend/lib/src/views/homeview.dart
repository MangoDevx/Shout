import 'package:flutter/material.dart';
import 'package:frontend/src/controllers/homecontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _onBackPressed(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: homeAppBar(),
        body: SizedBox.expand(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Container();
                  },
                ),
              ),
              BottomChatBar(
                onSendMessage: (String message) {
                  // TODO: Handle message sending

                },
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget homeAppBar() {
    // TODO: Design top bar
    return AppBar(
      backgroundColor: Theme.of(context).primaryColorLight,
      centerTitle: true,
      title: Image.asset('assets/shoutnotext.png',
          fit: BoxFit.contain, height: 35),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
        onPressed: () => _onBackPressed(),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Theme.of(context).primaryColor,
          ),
          tooltip: 'Open Settings',
          onPressed: () {
            // TODO: Open settings
          },
        ),
      ],
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Go back'),
              ),
              TextButton(
                onPressed: () {}, // TODO: Exit app
                child: const Text('Exit'),
              ),
            ],
          );
        });
  }
}

class BottomChatBar extends StatefulWidget {
  final Function(String message) onSendMessage;

  const BottomChatBar({super.key, required this.onSendMessage});

  @override
  State<BottomChatBar> createState() => _BottomChatBarState();
}

class _BottomChatBarState extends State<BottomChatBar> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isComposingMessage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon:
                Icon(Icons.photo_camera, color: Theme.of(context).primaryColor),
            onPressed: () {
              // TODO: Implement media upload functionality
            },
          ),
          Expanded(
              child: TextField(
            controller: _textEditingController,
            onChanged: (String message) {
              setState(() {
                _isComposingMessage = message.isNotEmpty;
              });
            },
            onSubmitted: _handleSubmitted,
            style: const TextStyle(color: Color(0xff616161)),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              isDense: true,
              hintText: 'Type message',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(30.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          )),
          IconButton(
            icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
            onPressed: _isComposingMessage
                ? () => _handleSubmitted(_textEditingController.text)
                : null,
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String message) {
    if (message.isEmpty) return;

    widget.onSendMessage(message);
    _textEditingController.clear();
    setState(() {
      _isComposingMessage = false;
    });
  }
}
