import 'package:http/http.dart' as http;

import 'network/utils.dart';
import 'storage.dart';

void processAuthorizationResponse(http.Response response) {
  var responseBody = getResponseBody(response);
  storage.name = responseBody['user']['name'];
}
