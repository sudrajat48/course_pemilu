import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/api.dart';
import '../config/app_color.dart';
import '../controller/c_detail_pemilu.dart';
import '../model/pemilu.dart';

class DetailPemiluPage extends StatelessWidget {
  const DetailPemiluPage({Key? key, required this.pemilu}) : super(key: key);
  final Pemilu pemilu;

  @override
  Widget build(BuildContext context) {
    context.read<CDetailPemilu>().setListCalon(pemilu.id);
    return Scaffold(
      appBar: DView.appBarCenter('Detail Pemilu'),
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
              ],
            ),
          ),
          DView.spaceHeight(),
          if (pemilu.status == 'Selesai') pemenang(),
          if (pemilu.status == 'Selesai') DView.spaceHeight(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Calon',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          calon(),
        ],
      ),
    );
  }

  Widget pemenang() {
    return Consumer<CDetailPemilu>(
      builder: (context, _, child) {
        if (_.listPemenang.isEmpty) return DView.nothing();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Pemenang',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              itemCount: _.listPemenang.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Map pemenang = _.listPemenang[index];
                return Container(
                  margin: const EdgeInsets.only(top: 16),
                  height: 240,
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          elevation: 4,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 8),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          '${Api.foto}/${pemenang['foto']}',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    DView.spaceHeight(8),
                                    Text(
                                      pemenang['nama'],
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
                                  pemenang['nomor'],
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DView.spaceWidth(),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.primary,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                pemenang['vote'].toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                ),
                              ),
                              const Text(
                                'vote',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget calon() {
    return Consumer<CDetailPemilu>(
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
            Map calon = _.listCalon[index];
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
                              '${Api.foto}/${calon['foto']}',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        DView.spaceHeight(8),
                        Text(
                          calon['nama'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${calon['vote']} vote',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
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
                      calon['nomor'],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
