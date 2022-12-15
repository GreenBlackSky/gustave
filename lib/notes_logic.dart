import 'package:gustave/gustave/network/utils.dart';

import 'notes_requests.dart';
import 'notes_responses.dart';

Future<void> syncNotes() async {
  await requestNotes().then(processNotesResponse);
}

Future<void> createNote(String text) async {
  var response = await requestCreateNote(text);
  getResponseBody(response);
  await requestNotes().then(processNotesResponse);
}

Future<void> editNote(int id, String text) async {
  var response = await requestEditNote(id, text);
  getResponseBody(response);
  await requestNotes().then(processNotesResponse);
}

Future<void> deleteNote(int id) async {
  var response = await requestDeleteNote(id);
  getResponseBody(response);
  await requestNotes().then(processNotesResponse);
}
