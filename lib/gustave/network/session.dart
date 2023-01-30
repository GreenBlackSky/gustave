import "dart:convert";
import 'package:http/http.dart' as http;

Map<String, String> baseHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Access-Control-Allow-Origin': '*'
};

//TODO init session with parameters
// TODO rework http
class Session {
  // String host = 'http://api_service:5004/';
  // String host = 'http://localhost:5003/';
  String host = 'localhost';
  int port = 5003;
  Map<String, String> _headers = new Map<String, String>.from(baseHeaders);

  void clearSession() {
    this._headers = new Map<String, String>.from(baseHeaders);
  }

  void setToken(http.Response response) {
    if (response.statusCode != 200) {
      return;
    }
    var responseData = jsonDecode(response.body);
    String? jwt = responseData['access_token'];
    if (jwt != null) {
      this._headers!['Authorization'] = "Bearer " + jwt;
    }
  }

  Future<http.Response> get(String url) async {
    http.Response response = await http
        .get(Uri(host: host, port: port, path: url), headers: this._headers);
    setToken(response);
    return response;
  }

  Future<http.Response> put(String url, [dynamic data]) async {
    if (data == null) {
      data = jsonEncode(<String, String>{});
    }
    http.Response response = await http.put(
        Uri(host: host, port: port, path: url),
        body: data,
        headers: this._headers);
    setToken(response);
    return response;
  }

  Future<http.Response> post(String url, [dynamic data]) async {
    if (data == null) {
      data = jsonEncode(<String, String>{});
    }
    http.Response response = await http.post(
        Uri(host: host, port: port, path: url),
        body: data,
        headers: this._headers);
    setToken(response);
    return response;
  }

  Future<http.Response> delete(String url) async {
    http.Response response = await http
        .delete(Uri(host: host, port: port, path: url), headers: this._headers);
    setToken(response);
    return response;
  }
}

var session = Session();
