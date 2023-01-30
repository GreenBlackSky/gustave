import 'user_requests.dart';
import 'user_responses.dart';
import 'storage.dart';

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
