import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/src/models/authresponsemodel.dart';
import '../models/securestorage.dart';

Future<AuthResponseModel> sendMessage() async {
  final storage = SecureStorage().storage;
  var username = await storage.read(key: 'username');
  print(username);

  return AuthResponseModel(statusCode: 0, responseBody: '0');
}
