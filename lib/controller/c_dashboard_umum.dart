import 'package:flutter/material.dart';

import '../model/pemilu.dart';
import '../source/pemilu_source.dart';

class CDashboardUmum extends ChangeNotifier {
  List<Pemilu> _list = [];
  List<Pemilu> get list => _list;
  setList() async {
    _list = await PemiluSource.gets('n');
    notifyListeners();
  }

  searchTahun(String query) async {
    _list = await PemiluSource.whereTahun(query, 'n');
    notifyListeners();
  }

  searchNama(String query) async {
    _list = await PemiluSource.whereNama(query, 'n');
    notifyListeners();
  }
}
