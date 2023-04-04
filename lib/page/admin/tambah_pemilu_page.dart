import 'package:course_pemilu/source/pemilu_source.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class TambahPemiluPage extends StatelessWidget {
  const TambahPemiluPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerNama = TextEditingController();
    final controllerTahun = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: DView.appBarCenter('Tambah Pemilu'),
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
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  PemiluSource.add(controllerNama.text, controllerTahun.text)
                      .then((success) {
                    if (success) {
                      DInfo.dialogSuccess(context, 'Berhasil Tambah Pemilu');
                      DInfo.closeDialog(
                        context,
                        actionAfterClose: () =>
                            Navigator.pop(context, 'update-pemilu'),
                      );
                    } else {
                      DInfo.dialogError(context, 'Gagal Tambah Pemilu');
                      DInfo.closeDialog(context);
                    }
                  });
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
