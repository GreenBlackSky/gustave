import 'package:http/http.dart' as http;

import 'utils.dart';

import 'package:coin_client/storage.dart';

void processNotesResponse(http.Response response) {
  var responseBody = getResponseBody(response);
  if (storage.activeNoteIndex == -1) {
    storage.activeNoteIndex = 0;
  }
  storage.notes.clear();
  for (Map<String, dynamic> noteJson in responseBody['notes']) {
    storage.notes.add(noteJson);
  }
}

void setActiveNoteAfterCreate(Map<String, dynamic> responseBody) {
  storage.activeNoteIndex = storage.notes.length - 1;
}

void setActiveNoteAfterDelete(Map<String, dynamic> responseBody) {
  if (storage.notes.length <= storage.activeNoteIndex) {
    storage.activeNoteIndex = storage.notes.length - 1;
  }
}
