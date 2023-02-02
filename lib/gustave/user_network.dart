import 'dart:convert';
import 'package:http/http.dart' as http;

import 'network/session.dart';
import 'network/utils.dart';
import 'storage.dart';

// Requests

Future<http.Response> requestRegistration(String name, String password) async {
  return session.post(
      'register',
      jsonEncode(<String, String>{
        'name': name,
        'password': password,
      }));
}

Future<http.Response> requestLogin(String name, String password) async {
  return session.post(
      'login',
      jsonEncode(<String, String>{
        'name': name,
        'password': password,
      }));
}

Future<http.Response> requestEditUser(
    String name, String password, String newPassword) async {
  return session.put(
      'edit_user',
      jsonEncode(<String, dynamic>{
        'name': name,
        'old_pass': password,
        'new_pass': newPassword
      }));
}

Future<http.Response> requestUserData() async {
  return session.get('user_data');
}

// Respones

void processAuthorizationResponse(http.Response response) {
  var responseBody = getResponseBody(response);
  storage.userName = responseBody['user']['name'];
}

// Logic

Future<void> syncUser() async {
  await requestUserData().then(processAuthorizationResponse);
}

Future<void> loadDataFromServerOnRegister(List<dynamic> args) async {
  String name = args[0];
  String password = args[1];
  await requestRegistration(name, password).then(processAuthorizationResponse);
  await storage.sync();
}

Future<void> loadDataFromServerOnLogin(List<dynamic> args) async {
  String name = args[0];
  String password = args[1];
  await requestLogin(name, password).then(processAuthorizationResponse);
  await storage.sync();
}

Future<void> editUser(List<dynamic> args) async {
  String name = args[0];
  String password = args[1];
  String newPassword = args[2];
  await requestEditUser(name, password, newPassword);
  await syncUser();
}
