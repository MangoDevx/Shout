import 'dart:convert';
import 'package:frontend/src/models/securestorage.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/src/models/authresponsemodel.dart';
import 'package:frontend/src/models/loginauthmodel.dart';
import 'package:frontend/src/models/registerauthmodel.dart';

Future<AuthResponseModel> sendLoginCredentials(
    String username, String password) async {
  LoginAuthModel payload =
      LoginAuthModel(username: username, password: password);
  String jsonPayload = jsonEncode(payload);

  // TODO: This really shouldn't be static but since its a small project right now, fix in future if desired
  var url = Uri.https("shoutmessaging.azurewebsites.net", "api/auth/login");
  var response = await http.post(url,
      body: jsonPayload, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    final storage = SecureStorage().storage;
    await storage.write(key: 'username', value: username);
  }

  return AuthResponseModel(
      statusCode: response.statusCode, responseBody: response.body);
}

Future<AuthResponseModel> sendRegistrationCredentials(
    String username, String password, String phoneNumber) async {
  RegisterAuthModel payload = RegisterAuthModel(
      username: username, password: password, phoneNumber: phoneNumber);
  String jsonPayload = jsonEncode(payload);

  var url = Uri.https("shoutmessaging.azurewebsites.net", "api/auth/register");
  var response = await http.post(url,
      body: jsonPayload, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    final storage = SecureStorage().storage;
    await storage.write(key: 'username', value: username);
  }

  return AuthResponseModel(
      statusCode: response.statusCode, responseBody: response.body);
}
