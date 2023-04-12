import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/src/models/loginpayload.dart';

Future<bool> sendLoginCredentials(String username, String password) async {
  LoginPayload payload = LoginPayload(username: username, password: password);
  String jsonPayload = jsonEncode(payload);

  // TODO: This really shouldn't be static but since its a small project right now, fix in future if desired
  var url = Uri.https("https:/shoutmessaging.azurewebsites.net", "api/auth/login");
  var response = await http.post(url, body: jsonPayload);

  if(response.statusCode == 200) {
    return true;
  }
  else {
    // TODO: Remove print in production
    print(response.body);
    return false;
  }
}

bool sendRegistrationCredentials(String username, String password, String phoneNumber) {
  return false;
}