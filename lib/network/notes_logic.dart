import 'requests/notes_requests.dart';
import 'responses/notes_responses.dart';
import 'responses/utils.dart';

Future<void> syncNotes() async {
  return requestNotes().then(processNotesResponse);
}

Future<void> createNote(String name) async {
  var response = await requestCreateNote(
    name,
  );
  var responseBody = getResponseBody(response);
  await requestNotes().then(processNotesResponse);
  setActiveNoteAfterCreate(responseBody);
}

Future<void> editNote(int id, String text) async {
  var response = await requestEditNote(id, text);
  getResponseBody(response);
  await requestNotes().then(processNotesResponse);
}

Future<void> deleteNote(int id) async {
  var response = await requestDeleteNote(id);
  var responseBody = getResponseBody(response);
  await requestNotes().then(processNotesResponse);
  setActiveNoteAfterDelete(responseBody);
}
