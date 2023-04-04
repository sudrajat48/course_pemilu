import 'dart:convert';

import 'package:http/http.dart';

import '../config/api.dart';
import '../model/pemilu.dart';

class PemiluSource {
  static final Client _client = Client();

  static Future<bool> add(String nama, String tahun) async {
    String url = '${Api.pemilu}/add.php';
    Response response = await _client.post(Uri.parse(url), body: {
      'nama': nama,
      'tahun': tahun,
    });
    Map responseBody = jsonDecode(response.body);
    return responseBody['success'];
  }

  static Future<bool> delete(String id) async {
    String url = '${Api.pemilu}/delete.php';
    Response response = await _client.post(Uri.parse(url), body: {
      'id': id,
    });
    Map responseBody = jsonDecode(response.body);
    return responseBody['success'];
  }

  /// admin: 'y' or 'n'
  static Future<List<Pemilu>> gets(String admin) async {
    String url = '${Api.pemilu}/get.php';
    Response response = await _client.post(Uri.parse(url), body: {
      'admin': admin,
    });
    Map responseBody = jsonDecode(response.body);
    if (responseBody['success']) {
      return List.from(responseBody['data'])
          .map((e) => Pemilu.fromJson(e))
          .toList();
    }
    return [];
  }

  static Future<bool> update(
      String id, String nama, String tahun, String status) async {
    String url = '${Api.pemilu}/update.php';
    Response response = await _client.post(Uri.parse(url), body: {
      'id': id,
      'nama': nama,
      'tahun': tahun,
      'status': status,
    });
    Map responseBody = jsonDecode(response.body);
    return responseBody['success'];
  }

  static Future<List<Pemilu>> whereAktif() async {
    String url = '${Api.pemilu}/where_aktif.php';
    Response response = await _client.get(Uri.parse(url));
    Map responseBody = jsonDecode(response.body);
    if (responseBody['success']) {
      return List.from(responseBody['data'])
          .map((e) => Pemilu.fromJson(e))
          .toList();
    }
    return [];
  }

  static Future<Pemilu?> whereId(String id) async {
    String url = '${Api.pemilu}/where_id.php';
    Response response = await _client.post(Uri.parse(url), body: {
      'id': id,
    });
    Map responseBody = jsonDecode(response.body);
    if (responseBody['success']) {
      return Pemilu.fromJson(responseBody['data']);
    }
    return null;
  }

  static Future<List<Pemilu>> whereNama(String nama, String admin) async {
    String url = '${Api.pemilu}/where_nama.php';
    Response response = await _client.post(Uri.parse(url), body: {
      'nama': nama,
      'admin': admin,
    });
    Map responseBody = jsonDecode(response.body);
    if (responseBody['success']) {
      return List.from(responseBody['data'])
          .map((e) => Pemilu.fromJson(e))
          .toList();
    }
    return [];
  }

  static Future<List<Pemilu>> whereTahun(String tahun, String admin) async {
    String url = '${Api.pemilu}/where_tahun.php';
    Response response = await _client.post(Uri.parse(url), body: {
      'tahun': tahun,
      'admin': admin,
    });
    Map responseBody = jsonDecode(response.body);
    if (responseBody['success']) {
      return List.from(responseBody['data'])
          .map((e) => Pemilu.fromJson(e))
          .toList();
    }
    return [];
  }
}
