import 'dart:convert';

import 'package:course_pemilu/controller/c_tambah_calon.dart';
import 'package:course_pemilu/model/pemilu.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../source/calon_source.dart';

class TambahCalonPage extends StatelessWidget {
  const TambahCalonPage({Key? key, required this.pemilu}) : super(key: key);
  final Pemilu pemilu;

  @override
  Widget build(BuildContext context) {
    final controllerNomor = TextEditingController();
    final controllerNama = TextEditingController();
    final controllerPartai = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return ChangeNotifierProvider(
      create: (BuildContext context) => CTambahCalon(),
      builder: (context, _) {
        return Scaffold(
          appBar: DView.appBarCenter('Tambah Calon'),
          body: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                DInput(
                  controller: controllerNomor,
                  hint: 'Nomor Calon',
                  validator: (value) => value == '' ? 'Jangan kosong' : null,
                ),
                DView.spaceHeight(),
                DInput(
                  controller: controllerNama,
                  hint: 'Nama Calon',
                  validator: (value) => value == '' ? 'Jangan kosong' : null,
                ),
                DView.spaceHeight(),
                DInput(
                  controller: controllerPartai,
                  hint: 'Nama Partai',
                  validator: (value) => value == '' ? 'Jangan kosong' : null,
                ),
                DView.spaceHeight(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CTambahCalon>().pilihFoto();
                    },
                    child: const Text('Pilih Foto'),
                  ),
                ),
                DView.spaceHeight(4),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: Consumer<CTambahCalon>(builder: (context, _, child) {
                    if (_.fotoByte == null) return const Text('Foto');
                    return Image.memory(
                      _.fotoByte!,
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width * 0.5,
                    );
                  }),
                ),
                DView.spaceHeight(30),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (context.read<CTambahCalon>().foto != null) {
                        CalonSource.add(
                          controllerNomor.text,
                          controllerNama.text,
                          controllerPartai.text,
                          context.read<CTambahCalon>().foto!,
                          base64Encode(context.read<CTambahCalon>().fotoByte!),
                          pemilu.id,
                        ).then((success) {
                          if (success) {
                            DInfo.dialogSuccess(
                                context, 'Berhasil Tambah Calon');
                            DInfo.closeDialog(
                              context,
                              actionAfterClose: () =>
                                  Navigator.pop(context, 'update-calon'),
                            );
                          } else {
                            DInfo.dialogError(context, 'Gagal Tambah Calon');
                            DInfo.closeDialog(context);
                          }
                        });
                      } else {
                        DInfo.dialogError(context, 'Foto tidak boleh kosong');
                        DInfo.closeDialog(context);
                      }
                    }
                  },
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
