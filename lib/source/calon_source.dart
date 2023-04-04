import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:http/http.dart';

import '../config/api.dart';
import '../model/calon.dart';

class CalonSource {
  static final Client _client = Client();

  static Future<bool> add(
    String nomor,
    String nama,
    String partai,
    String foto,
    String fotoBase64,
    String idPemilu,
  ) async {
    String url = '${Api.calon}/add.php';
    Response response = await _client.post(Uri.parse(url), body: {
      'nomor': nomor,
      'nama': nama,
      'partai': partai,
      'foto': '${DateTime.now().microsecondsSinceEpoch}_$foto',
      'foto_base64': fotoBase64,
      'id_pemilu': idPemilu,
    });
    DMethod.printTitle('Tambah Calon', response.body);
    Map responseBody = jsonDecode(response.body);
    return responseBody['success'];
  }

  static Future<bool> delete(String id, String foto) async {
    String url = '${Api.calon}/delete.php';
    Response response = await _client.post(Uri.parse(url), body: {
      'id': id,
      'foto': foto,
    });
    Map responseBody = jsonDecode(response.body);
    return responseBody['success'];
  }

  static Future<List<Map>> wherePemiluAndVote(String idPemilu) async {
    String url = '${Api.calon}/where_pemilu_and_vote.php';
    Response response = await _client.post(Uri.parse(url), body: {
      'id_pemilu': idPemilu,
    });
    Map responseBody = jsonDecode(response.body);
    if (responseBody['success']) {
      return List<Map>.from(responseBody['data']);
    }
    return [];
  }

  static Future<List<Calon>> wherePemilu(String idPemilu) async {
    String url = '${Api.calon}/where_pemilu.php';
    Response response = await _client.post(Uri.parse(url), body: {
      'id_pemilu': idPemilu,
    });
    Map responseBody = jsonDecode(response.body);
    if (responseBody['success']) {
      return List.from(responseBody['data'])
          .map((e) => Calon.fromJson(e))
          .toList();
    }
    return [];
  }
}
