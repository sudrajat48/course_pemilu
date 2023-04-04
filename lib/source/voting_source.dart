import 'dart:convert';

import 'package:http/http.dart';

import '../config/api.dart';

class VotingSource {
  static final Client _client = Client();

  static Future<bool> add(String idPemilu, String idCalon, String nik) async {
    String url = '${Api.voting}/add.php';
    Response response = await _client.post(Uri.parse(url), body: {
      'id_pemilu': idPemilu,
      'id_calon': idCalon,
      'nik': nik,
    });
    Map responseBody = jsonDecode(response.body);
    return responseBody['success'];
  }

  static Future<bool> check(String idPemilu, String nik) async {
    String url = '${Api.voting}/check.php';
    Response response = await _client.post(Uri.parse(url), body: {
      'id_pemilu': idPemilu,
      'nik': nik,
    });
    Map responseBody = jsonDecode(response.body);
    return responseBody['success'];
  }
}
