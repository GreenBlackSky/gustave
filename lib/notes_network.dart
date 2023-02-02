import 'dart:convert';

import 'package:http/http.dart' as http;

import 'gustave/network/utils.dart';
import 'gustave/network/session.dart';
import 'gustave/storage.dart';

import 'note.dart';

// Requests

Future<http.Response> requestNotes() async {
  return session.get('notes');
}

Future<http.Response> requestCreateNote(String text) async {
  return session.post(
      'create_note',
      jsonEncode(<String, String>{
        'text': text,
      }));
}

Future<http.Response> requestEditNote(int noteID, String text) async {
  return session.put(
      'edit_note/$noteID', jsonEncode(<String, dynamic>{'text': text}));
}

Future<http.Response> requestDeleteNote(int noteID) async {
  return session.delete('delete_note/$noteID');
}

// Responces
void processNotesResponse(http.Response response) {
  var responseBody = getResponseBody(response);
  storage.getStorage("notes").clear();
  for (Map<String, dynamic> noteJson in responseBody['notes']) {
    storage.getStorage("notes").add(Note(noteJson['id'], noteJson['text']));
  }
}

// Logic
Future<void> syncNotes() async {
  await requestNotes().then(processNotesResponse);
}

Future<void> createNote(List<dynamic> args) async {
  String text = args[1];
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
