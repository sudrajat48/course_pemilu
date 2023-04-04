import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/app_color.dart';
import '../../config/app_route.dart';
import '../../controller/c_dashboard_umum.dart';
import '../../model/pemilu.dart';

class DashboardUmumPage extends StatelessWidget {
  const DashboardUmumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerTahun = TextEditingController();
    final controllerNama = TextEditingController();
    context.read<CDashboardUmum>().setList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pemilu App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<CDashboardUmum>().setList();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.inputNIK);
        },
        icon: const Icon(Icons.add_circle_rounded, size: 40),
        label: const Text('Pilih', style: TextStyle(fontSize: 16)),
        foregroundColor: Colors.white,
        backgroundColor: AppColor.primary,
        extendedPadding: const EdgeInsets.only(left: 4, right: 16),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black12,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter Pemilu Berdasarkan:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                DView.spaceHeight(8),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 30,
                        child: TextField(
                          controller: controllerTahun,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            hintText: 'Cari tahun...',
                          ),
                        ),
                      ),
                    ),
                    DView.spaceWidth(12),
                    SizedBox(
                      height: 30,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context
                              .read<CDashboardUmum>()
                              .searchTahun(controllerTahun.text);
                        },
                        icon: const Icon(Icons.search),
                        label: const Text('Tahun'),
                      ),
                    ),
                  ],
                ),
                DView.spaceHeight(8),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 30,
                        child: TextField(
                          controller: controllerNama,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            hintText: 'Cari nama...',
                          ),
                        ),
                      ),
                    ),
                    DView.spaceWidth(12),
                    SizedBox(
                      height: 30,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context
                              .read<CDashboardUmum>()
                              .searchNama(controllerNama.text);
                        },
                        icon: const Icon(Icons.search),
                        label: const Text('Nama'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          DView.spaceHeight(8),
          Center(
            child: Container(
              height: 6,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          DView.spaceHeight(12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                dotStatus(Colors.white, 'Aktif'),
                DView.spaceWidth(24),
                dotStatus(Colors.red[300]!, 'Selesai'),
              ],
            ),
          ),
          DView.spaceHeight(),
          Expanded(
            child: Consumer<CDashboardUmum>(
              builder: (context, _, child) {
                if (_.list.isEmpty) return DView.empty();
                return ListView.builder(
                  itemCount: _.list.length,
                  padding: const EdgeInsets.only(bottom: 80),
                  itemBuilder: (context, index) {
                    Pemilu pemilu = _.list[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoute.detailPemilu,
                          arguments: pemilu,
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                          16,
                          index == 0 ? 16 : 8,
                          16,
                          index == _.list.length - 1 ? 16 : 8,
                        ),
                        decoration: BoxDecoration(
                          color: pemilu.status == 'Non-Aktif'
                              ? Colors.grey[300]
                              : pemilu.status == 'Aktif'
                                  ? Colors.white
                                  : Colors.red[300],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.black26,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                pemilu.nama,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            DView.spaceWidth(),
                            Text(
                              pemilu.tahun,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
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

  Widget dotStatus(Color color, String label) {
    return Row(
      children: [
        Container(
          height: 18,
          width: 18,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(),
          ),
        ),
        DView.spaceWidth(8),
        Text(label),
      ],
    );
  }
}
