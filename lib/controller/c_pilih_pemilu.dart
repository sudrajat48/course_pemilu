import 'package:flutter/material.dart';

import '../model/pemilu.dart';
import '../source/pemilu_source.dart';

class CPilihPemilu extends ChangeNotifier {
  List<Pemilu> _listPemilu = [];
  List<Pemilu> get listPemilu => _listPemilu;
  setListPemilu() async {
    _listPemilu = await PemiluSource.whereAktif();
    notifyListeners();
  }
}
