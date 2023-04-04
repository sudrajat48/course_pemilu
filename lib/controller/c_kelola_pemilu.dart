import 'package:flutter/cupertino.dart';

import '../model/calon.dart';
import '../source/calon_source.dart';

class CKelolaPemilu extends ChangeNotifier {
  List<Calon> _listCalon = [];
  List<Calon> get listCalon => _listCalon;
  setListCalon(String idPemilu) async {
    _listCalon = await CalonSource.wherePemilu(idPemilu);
    notifyListeners();
  }
}
