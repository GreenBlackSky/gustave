import 'gustave/network/utils.dart';

import 'notes_requests.dart';
import 'notes_responses.dart';

Future<void> syncNotes() async {
  await requestNotes().then(processNotesResponse);
}

Future<void> createNote(List<dynamic> args) async {
  String text = args[0];
  var response = await requestCreateNote(text);
  getResponseBody(response);
  await requestNotes().then(processNotesResponse);
}

Future<void> editNote(List<dynamic> args) async {
  int id = args[0];
  String text = args[1];
  var response = await requestEditNote(id, text);
  getResponseBody(response);
  await requestNotes().then(processNotesResponse);
}

Future<void> deleteNote(List<dynamic> args) async {
  int id = args[0];
  var response = await requestDeleteNote(id);
  getResponseBody(response);
  await requestNotes().then(processNotesResponse);
}
