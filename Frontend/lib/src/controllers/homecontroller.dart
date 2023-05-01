import 'dart:convert';
import 'dart:developer';
import 'package:frontend/src/models/messagemodel.dart';
import 'package:http/http.dart' as http;
import '../../auth.dart';
import '../models/usermodel.dart';

Future<void> signOut() async {
  await Auth().signOut();
}

Future<void> sendMessage(String message) async {
  var model = MessageModel(username: UserModel().username, body: message);
  var data = jsonEncode(model);
  var url = Uri.https('shoutmessaging.azurewebsites.net', 'newmsg');
  var response = await http.post(url, body: data, headers: {"Content-Type": "application/json"});
}