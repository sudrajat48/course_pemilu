import 'package:flutter/material.dart';

import '../model/calon.dart';
import '../source/calon_source.dart';
import '../source/voting_source.dart';

class CPilihCalon extends ChangeNotifier {
  bool? _hasPicked;
  bool? get hasPicked => _hasPicked;
  check(String idPemilu, String nik) async {
    _hasPicked = await VotingSource.check(idPemilu, nik);
    notifyListeners();
  }

  List<Calon> _listCalon = [];
  List<Calon> get listCalon => _listCalon;
  setListCalon(String idPemilu) async {
    _listCalon = await CalonSource.wherePemilu(idPemilu);
    notifyListeners();
  }
}
