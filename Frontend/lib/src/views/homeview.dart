import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/controllers/homecontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/auth.dart';
import 'package:frontend/src/models/usermodel.dart';
import 'package:frontend/src/views/settingsview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = Auth().currentUser;
  final messageList = <String>[];

  void handleMessages(List<String> messageList) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var user = message.data["username"];
      var body = message.data["body"];
      if (user != UserModel().username) {
        setState(() {
          messageList.add('$user@u$body');
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    handleMessages(messageList);
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
                  child: MessageListWidget(
                items: messageList,
              )),
              BottomChatBar(
                onSendMessage: (String message) async {
                  await sendMessage(message);
                  setState(() {
                    messageList.add("${UserModel().username}@u$message");
                  });
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
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
                onPressed: () {
                  Auth().signOut();
                },
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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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

class MessageListWidget extends StatelessWidget {
  final List<String> items;

  const MessageListWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final itemText = items[index];
          final isMe = itemText.startsWith(UserModel().username);
          final bubbleColor = isMe ? Colors.purple : Colors.blue;

          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: BubbleItem(
                body: itemText.split('@u')[1],
                username: itemText.split('@u')[0],
                color: bubbleColor,
              ),
            ),
          );
        },
      ),
    );
  }
}

class BubbleItem extends StatelessWidget {
  final String body;
  final Color color;
  final String username;

  const BubbleItem({
    Key? key,
    required this.body,
    required this.color,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double maxWidth = screenWidth * 0.6;

    final BorderRadiusGeometry borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(16.0),
      topRight: const Radius.circular(16.0),
      bottomLeft: (username == UserModel().username)
          ? const Radius.circular(16.0)
          : Radius.circular(0.0),
      bottomRight: (username == UserModel().username)
          ? const Radius.circular(0.0)
          : Radius.circular(16.0),
    );

    final String content = body.startsWith('${UserModel().username}@u')
        ? body.replaceFirst('${UserModel().username}@u', '').trim()
        : body.trim();

    return Column(
      crossAxisAlignment: (username == UserModel().username)
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Text(
            username,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            ),
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            borderRadius: borderRadius,
          ),
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double _getTextWidth(BuildContext context, String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(color: Colors.white),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: double.infinity);

    return textPainter.size.width + 32.0; // padding left + right
  }
}
