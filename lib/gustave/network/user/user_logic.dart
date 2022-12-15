import 'package:gustave/notes_logic.dart';
// TODO remove

import 'user_requests.dart';
import 'user_responses.dart';

Future<void> syncUser() async {
  await requestUserData().then(processAuthorizationResponse);
}

Future<void> loadDataFromServerOnRegister(String name, String password) async {
  await requestRegistration(name, password).then(processAuthorizationResponse);
  await syncNotes();
}

Future<void> loadDataFromServerOnLogin(String name, String password) async {
  await requestLogin(name, password).then(processAuthorizationResponse);
  await syncNotes();
}

Future<void> editUser(String name, String password, String newPassword) async {
  await requestEditUser(name, password, newPassword);
  await syncUser();
}
