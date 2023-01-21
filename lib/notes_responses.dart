import 'package:http/http.dart' as http;

import 'gustave/network/utils.dart';
import 'gustave/storage.dart';

void processNotesResponse(http.Response response) {
  var responseBody = getResponseBody(response);
  storage.notes.clear();
  for (Map<String, dynamic> noteJson in responseBody['notes']) {
    storage.notes.add(Note(noteJson['id'], noteJson['text']));
  }
}
