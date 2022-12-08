import 'requests/notes_requests.dart';
import 'responses/notes_responses.dart';
import 'responses/utils.dart';

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
