import 'package:course_pemilu/model/pemilu.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

import '../../source/pemilu_source.dart';

class UpdatePemiluPage extends StatefulWidget {
  const UpdatePemiluPage({Key? key, required this.pemilu}) : super(key: key);
  final Pemilu pemilu;

  @override
  State<UpdatePemiluPage> createState() => _UpdatePemiluPageState();
}

class _UpdatePemiluPageState extends State<UpdatePemiluPage> {
  final controllerNama = TextEditingController();
  final controllerTahun = TextEditingController();
  final controllerStatus = TextEditingController(text: 'Non-Aktif');
  final formKey = GlobalKey<FormState>();
  final listStatus = ['Non-Aktif', 'Aktif', 'Selesai'];

  simpan() {
    if (formKey.currentState!.validate()) {
      PemiluSource.update(
        widget.pemilu.id,
        controllerNama.text,
        controllerTahun.text,
        controllerStatus.text,
      ).then((success) {
        if (success) {
          DInfo.dialogSuccess(context, 'Berhasil Update Pemilu');
          DInfo.closeDialog(
            context,
            actionAfterClose: () => Navigator.pop(context, 'update-pemilu'),
          );
        } else {
          DInfo.dialogError(context, 'Gagal Update Pemilu');
          DInfo.closeDialog(context);
        }
      });
    }
  }

  @override
  void initState() {
    controllerNama.text = widget.pemilu.nama;
    controllerTahun.text = widget.pemilu.tahun;
    controllerStatus.text = widget.pemilu.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarCenter('Update Pemilu'),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DInput(
              controller: controllerNama,
              hint: 'Nama Pemilu',
              validator: (value) => value == '' ? 'Jangan kosong' : null,
            ),
            DView.spaceHeight(),
            DInput(
              controller: controllerTahun,
              hint: 'Tahun',
              validator: (value) => value == '' ? 'Jangan kosong' : null,
            ),
            DView.spaceHeight(),
            DropdownButtonFormField<String>(
              value: controllerStatus.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
              items: listStatus.map((e) {
                return DropdownMenuItem<String>(value: e, child: Text(e));
              }).toList(),
              onChanged: (String? value) {
                controllerStatus.text = value!;
              },
            ),
            DView.spaceHeight(),
            ElevatedButton(
              onPressed: () => simpan(),
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
