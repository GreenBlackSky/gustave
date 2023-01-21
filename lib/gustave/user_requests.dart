import 'dart:convert';
import 'package:http/http.dart' as http;

import 'network/session.dart';

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
