import 'dart:convert';

import 'package:http/http.dart';

import '../config/api.dart';

class UserSource {
  static final Client _client = Client();

  static Future<bool> login(String username, String password) async {
    String url = '${Api.admin}/login.php';
    Response response = await _client.post(Uri.parse(url), body: {
      'username': username,
      'password': password,
    });
    Map responseBody = jsonDecode(response.body);
    return responseBody['success'];
  }
}
