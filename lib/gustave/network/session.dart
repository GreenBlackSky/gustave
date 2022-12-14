import "dart:convert";
import 'package:http/http.dart' as http;

class Session {
  // String host = 'http://api_service:5004/';
  String host = 'http://localhost:5003/';
  Map<String, String> _baseHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Access-Control-Allow-Origin': '*'
  };
  Map<String, String> _headers;

  Session() {
    this.clearSession();
  }

  void clearSession() {
    this._headers = new Map<String, String>.from(_baseHeaders);
  }

  void setToken(http.Response response) {
    var responseData = jsonDecode(response.body);
    String jwt = responseData['access_token'];
    if (jwt != null) {
      this._headers['Authorization'] = "Bearer " + jwt;
    }
  }

  Future<http.Response> get(String url) async {
    http.Response response = await http.get(host + url, headers: this._headers);
    if (response.statusCode == 200) {
      setToken(response);
    }
    return response;
  }

  Future<http.Response> put(String url, [dynamic data]) async {
    if (data == null) {
      data = jsonEncode(<String, String>{});
    }
    http.Response response =
        await http.put(host + url, body: data, headers: this._headers);
    if (response.statusCode == 200) {
      setToken(response);
    }
    return response;
  }

  Future<http.Response> post(String url, [dynamic data]) async {
    if (data == null) {
      data = jsonEncode(<String, String>{});
    }
    http.Response response =
        await http.post(host + url, body: data, headers: this._headers);
    if (response.statusCode == 200) {
      setToken(response);
    }
    return response;
  }

  Future<http.Response> delete(String url) async {
    http.Response response =
        await http.delete(host + url, headers: this._headers);
    if (response.statusCode == 200) {
      setToken(response);
    }
    return response;
  }
}

var session = Session();
