import 'package:course_pemilu/model/calon.dart';
import 'package:d_button/d_button.dart';
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/api.dart';
import '../../config/app_route.dart';
import '../../controller/c_kelola_pemilu.dart';
import '../../model/pemilu.dart';
import '../../source/calon_source.dart';

class KelolaPemiluPage extends StatelessWidget {
  const KelolaPemiluPage({Key? key, required this.pemilu}) : super(key: key);
  final Pemilu pemilu;

  deleteCalon(BuildContext context, Calon calon) {
    DInfo.dialogConfirmation(
      context,
      'Hapus',
      'Yes untuk konfirmasi',
    ).then((yes) {
      if (yes ?? false) {
        CalonSource.delete(calon.id, calon.foto).then((success) {
          if (success) {
            context.read<CKelolaPemilu>().setListCalon(pemilu.id);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<CKelolaPemilu>().setListCalon(pemilu.id);
    return Scaffold(
      appBar: DView.appBarCenter('Kelola Pemilu'),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pemilu.nama,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                DView.spaceHeight(4),
                Text(
                  'Tahun: ${pemilu.tahun}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                DView.spaceHeight(),
                Text(
                  'Status',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                DView.spaceHeight(4),
                Text(
                  pemilu.status,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                DView.spaceHeight(),
                Text(
                  'Calon',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                DView.spaceHeight(8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.tambahCalon,
                        arguments: pemilu,
                      ).then((value) {
                        if (value != null && value == 'update-calon') {
                          // update perubahan jika berhasil update pemilu
                          context.read<CKelolaPemilu>().setListCalon(pemilu.id);
                        }
                      });
                    },
                    child: const Text('Tambah Calon'),
                  ),
                ),
              ],
            ),
          ),
          Consumer<CKelolaPemilu>(
            builder: (context, _, child) {
              if (_.listCalon.isEmpty) return DView.empty('Belum ada calon');
              return GridView.builder(
                itemCount: _.listCalon.length,
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  Calon calon = _.listCalon[index];
                  return Material(
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
                        Align(
                          alignment: Alignment.topRight,
                          child: DButtonFlat(
                            onClick: () => deleteCalon(context, calon),
                            height: 40,
                            width: 40,
                            radius: 12,
                            mainColor: Colors.white,
                            child: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
