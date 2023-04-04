import 'package:flutter/material.dart';

import '../model/pemilu.dart';
import '../source/pemilu_source.dart';

class CDashboardAdmin extends ChangeNotifier {
  List<Pemilu> _list = [];
  List<Pemilu> get list => _list;
  setList() async {
    _list = await PemiluSource.gets('y');
    notifyListeners();
  }

  searchTahun(String query) async {
    _list = await PemiluSource.whereTahun(query, 'y');
    notifyListeners();
  }

  searchNama(String query) async {
    _list = await PemiluSource.whereNama(query, 'y');
    notifyListeners();
  }
}
