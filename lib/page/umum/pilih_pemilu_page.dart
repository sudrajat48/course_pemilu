import 'package:course_pemilu/model/pemilu.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_route.dart';
import '../../controller/c_pilih_pemilu.dart';

class PilihPemiluPage extends StatelessWidget {
  const PilihPemiluPage({Key? key, required this.nik}) : super(key: key);
  final String nik;

  @override
  Widget build(BuildContext context) {
    context.read<CPilihPemilu>().setListPemilu();
    return Scaffold(
      appBar: DView.appBarCenter('Pilih Pemilu'),
      body: Consumer<CPilihPemilu>(
        builder: (context, _, child) {
          if (_.listPemilu.isEmpty) return DView.empty();
          return ListView.builder(
            itemCount: _.listPemilu.length,
            itemBuilder: (context, index) {
              Pemilu pemilu = _.listPemilu[index];
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  index == 0 ? 16 : 8,
                  16,
                  index == _.listPemilu.length - 1 ? 16 : 8,
                ),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.pilihCalon,
                        arguments: {'pemilu': pemilu, 'nik': nik},
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              pemilu.nama,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const Icon(Icons.navigate_next),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
