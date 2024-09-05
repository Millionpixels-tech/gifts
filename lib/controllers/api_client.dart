import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static final String _baseUrl =
      '${dotenv.env['API_HOST']}:${dotenv.env['API_PORT']}/api';
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<http.Response> get(String endpoint) async {
    return _sendRequest('GET', endpoint);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    return _sendRequest('POST', endpoint, body: body);
  }

  Future<http.Response> delete(
      String endpoint, Map<String, dynamic> body) async {
    return _sendRequest('DELETE', endpoint, body: body);
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    return _sendRequest('PUT', endpoint, body: body);
  }

  Future<http.Response> postMultipart(String endpoint,
      Map<String, String> fields, List<http.MultipartFile> files) async {
    String? accessToken = await secureStorage.read(key: 'accessToken');
    var url = Uri.parse('$_baseUrl$endpoint');
    var headers = {
      "Authorization": "Bearer $accessToken",
    };

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields.addAll(fields);

    for (var file in files) {
      request.files.add(file);
    }

    var response = await request.send();

    return http.Response.fromStream(response);
  }

  Future<http.Response> _sendRequest(String method, String endpoint,
      {Map<String, dynamic>? body}) async {
    String? accessToken = await secureStorage.read(key: 'accessToken');
    var url = Uri.parse('$_baseUrl$endpoint');
    var headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer $accessToken",
    };

    http.Response response;
    if (method == 'GET') {
      response = await http.get(url, headers: headers);
    } else if (method == 'POST') {
      response = await http.post(url, headers: headers, body: jsonEncode(body));
    } else if (method == 'DELETE') {
      response =
          await http.delete(url, headers: headers, body: jsonEncode(body));
    } else if (method == 'PUT') {
      response = await http.put(url, headers: headers, body: jsonEncode(body));
    } else {
      throw Exception('Unsupported HTTP method');
    }

    if (response.statusCode == 401 || response.statusCode == 403) {
      await _refreshToken();
      accessToken = await secureStorage.read(key: 'accessToken');
      headers["Authorization"] = "Bearer $accessToken";

      if (method == 'GET') {
        response = await http.get(url, headers: headers);
      } else {
        response =
            await http.post(url, headers: headers, body: jsonEncode(body));
      }
    }

    return response;
  }

  Future<void> _refreshToken() async {
    String? refreshToken = await secureStorage.read(key: 'refreshToken');
    var url = Uri.parse('$_baseUrl/auth/token');
    var headers = {
      "Content-type": "application/json",
    };
    var body = jsonEncode({"refreshToken": refreshToken});

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      await secureStorage.write(key: 'accessToken', value: data['accessToken']);
    } else {
      await secureStorage.delete(key: 'accessToken');
      await secureStorage.delete(key: 'refreshToken');
      throw Exception('Failed to refresh token');
    }
  }
}
