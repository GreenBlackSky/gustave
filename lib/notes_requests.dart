import 'dart:convert';
import 'package:http/http.dart' as http;

import 'gustave/network/session.dart';

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
