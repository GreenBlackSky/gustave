import 'package:http/http.dart' as http;

import 'utils.dart';

import 'package:coin_client/storage.dart';

void processNotesResponse(http.Response response) {
  var responseBody = getResponseBody(response);
  storage.notes.clear();
  for (Map<String, dynamic> noteJson in responseBody['notes']) {
    storage.notes.add(Note(noteJson['id'], noteJson['text']));
  }
}
