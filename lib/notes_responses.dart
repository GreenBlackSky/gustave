import 'package:http/http.dart' as http;

import 'gustave/network/utils.dart';
import 'gustave/storage.dart';

import 'note.dart';

void processNotesResponse(http.Response response) {
  var responseBody = getResponseBody(response);
  storage.stuff.clear();
  for (Map<String, dynamic> noteJson in responseBody['notes']) {
    storage.stuff.add(Note(noteJson['id'], noteJson['text']));
  }
}
