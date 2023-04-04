import 'package:course_pemilu/controller/c_pilih_calon.dart';
import 'package:course_pemilu/model/pemilu.dart';
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/api.dart';
import '../../model/calon.dart';
import '../../source/voting_source.dart';

class PilihCalonPage extends StatelessWidget {
  const PilihCalonPage({Key? key, required this.nik, required this.pemilu})
      : super(key: key);
  final String nik;
  final Pemilu pemilu;

  pilih(BuildContext context, Calon calon) {
    DInfo.dialogConfirmation(
      context,
      'Konfirmasi',
      'Tekan Yes untuk konfirmasi pilihan anda',
    ).then((yes) {
      if (yes ?? false) {
        VotingSource.add(pemilu.id, calon.id, nik).then((success) {
          if (success) {
            DInfo.dialogSuccess(context, 'Berhasil Memilih');
            DInfo.closeDialog(context, actionAfterClose: () {
              Navigator.pop(context);
            });
          } else {
            DInfo.dialogError(context, 'Gagal Memilih');
            DInfo.closeDialog(context);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<CPilihCalon>().check(pemilu.id, nik);
    context.read<CPilihCalon>().setListCalon(pemilu.id);
    return Scaffold(
      appBar: DView.appBarCenter('Pilih Calon'),
      body: Column(
        children: [
          Consumer<CPilihCalon>(
            builder: (context, _, child) {
              if (_.hasPicked ?? false) {
                return ListTile(
                  tileColor: Colors.green[100],
                  title: const Text(
                    'Anda Sudah Memilih',
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    pemilu.nama,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }
              return ListTile(
                tileColor: Colors.red[100],
                title: const Text(
                  'Anda Belum Memilih',
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  pemilu.nama,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<CPilihCalon>(
              builder: (context, _, child) {
                if (_.listCalon.isEmpty) return DView.nothing();
                return GridView.builder(
                  itemCount: _.listCalon.length,
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    Calon calon = _.listCalon[index];
                    return GestureDetector(
                      onTap: () {
                        if (_.hasPicked ?? false) {
                          // user tidak bisa tambah voting lagi
                        } else {
                          pilih(context, calon);
                        }
                      },
                      child: Material(
                        elevation: 4,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        '${Api.foto}/${calon.foto}',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  DView.spaceHeight(8),
                                  Text(
                                    calon.nama,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                calon.nomor,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
