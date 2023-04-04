import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


class CTambahCalon extends ChangeNotifier {
  String? _foto;
  String? get foto => _foto;

  Uint8List? _fotoByte;
  Uint8List? get fotoByte => _fotoByte;

  pilihFoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      _foto = result.files.single.name;
      _fotoByte = file.readAsBytesSync();
      notifyListeners();
    }
  }
}
