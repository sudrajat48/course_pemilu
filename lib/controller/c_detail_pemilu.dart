import 'package:flutter/cupertino.dart';
import '../source/calon_source.dart';

class CDetailPemilu extends ChangeNotifier {
  final List<Map> _listPemenang = [];
  List<Map> get listPemenang => _listPemenang;

  List<Map> _listCalon = [];
  List<Map> get listCalon => _listCalon;

  setListCalon(String idPemilu) async {
    _listPemenang.clear();
    _listCalon = await CalonSource.wherePemiluAndVote(idPemilu);
    List<Map> list = listCalon;
    list.sort((a, b) => b['vote'].compareTo(a['vote']));
    for (var i = 0; i < list.length; i++) {
      if (i == 0) {
        _listPemenang.add(list[i]);
      } else {
        if (list[i]['vote'] == list[0]['vote']) {
          _listPemenang.add(list[i]);
        }
      }
    }
    notifyListeners();
  }
}

// const calon = {
//   "id": '1',
//   "nomor": '01',
//   "nama": 'nama',
//   "partai": 'partai',
//   "foto": 'foto',
//   "id_pemilu": '1',
//   "vote": 1,
// };
