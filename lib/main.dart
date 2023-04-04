import 'package:course_pemilu/config/app_color.dart';
import 'package:course_pemilu/config/app_route.dart';
import 'package:course_pemilu/controller/c_dashboard_admin.dart';
import 'package:course_pemilu/controller/c_dashboard_umum.dart';
import 'package:course_pemilu/controller/c_detail_pemilu.dart';
import 'package:course_pemilu/controller/c_kelola_pemilu.dart';
import 'package:course_pemilu/controller/c_pilih_calon.dart';
import 'package:course_pemilu/controller/c_pilih_pemilu.dart';
import 'package:course_pemilu/model/pemilu.dart';
import 'package:course_pemilu/page/admin/dashboard_admin_page.dart';
import 'package:course_pemilu/page/admin/tambah_pemilu_page.dart';
import 'package:course_pemilu/page/splash.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'page/admin/kelola_pemilu_page.dart';
import 'page/admin/tambah_calon_page.dart';
import 'page/admin/update_pemilu_page.dart';
import 'page/detail_pemilu_page.dart';
import 'page/login_page.dart';
import 'page/umum/dashboard_umum_page.dart';
import 'page/umum/input_nik.dart';
import 'page/umum/pilih_calon_page.dart';
import 'page/umum/pilih_pemilu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CDashboardAdmin>(
          create: (context) => CDashboardAdmin(),
        ),
        ChangeNotifierProvider<CKelolaPemilu>(
          create: (context) => CKelolaPemilu(),
        ),
        ChangeNotifierProvider<CDashboardUmum>(
          create: (context) => CDashboardUmum(),
        ),
        ChangeNotifierProvider<CPilihPemilu>(
          create: (context) => CPilihPemilu(),
        ),
        ChangeNotifierProvider<CPilihCalon>(
          create: (context) => CPilihCalon(),
        ),
        ChangeNotifierProvider<CDetailPemilu>(
          create: (context) => CDetailPemilu(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aplikasi Pemilu',
        theme: ThemeData(
          primaryColor: AppColor.primary,
          colorScheme: const ColorScheme.light(
            primary: AppColor.primary,
          ),
        ),
        onGenerateRoute: (RouteSettings routeSettings) {
          switch (routeSettings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) {
                return const SplashScreen();
              });
            case AppRoute.login:
              return MaterialPageRoute(builder: (context) {
                return LoginPage();
              });
            case AppRoute.dashboardAdmin:
              return MaterialPageRoute(builder: (context) {
                return const DashboardAdminPage();
              });
            case AppRoute.dashboardUmum:
              return MaterialPageRoute(builder: (context) {
                return const DashboardUmumPage();
              });
            case AppRoute.tambahPemilu:
              return MaterialPageRoute(builder: (context) {
                return const TambahPemiluPage();
              });
            case AppRoute.detailPemilu:
              return MaterialPageRoute(builder: (context) {
                return DetailPemiluPage(
                  pemilu: routeSettings.arguments as Pemilu,
                );
              });
            case AppRoute.updatePemilu:
              return MaterialPageRoute(builder: (context) {
                return UpdatePemiluPage(
                  pemilu: routeSettings.arguments as Pemilu,
                );
              });
            case AppRoute.kelolaPemilu:
              return MaterialPageRoute(builder: (context) {
                return KelolaPemiluPage(
                  pemilu: routeSettings.arguments as Pemilu,
                );
              });
            case AppRoute.tambahCalon:
              return MaterialPageRoute(builder: (context) {
                return TambahCalonPage(
                  pemilu: routeSettings.arguments as Pemilu,
                );
              });
            case AppRoute.inputNIK:
              return MaterialPageRoute(builder: (context) {
                return const InputNikPage();
              });
            case AppRoute.pilihPemilu:
              return MaterialPageRoute(builder: (context) {
                return PilihPemiluPage(
                  nik: routeSettings.arguments as String,
                );
              });
            case AppRoute.pilihCalon:
              return MaterialPageRoute(builder: (context) {
                return PilihCalonPage(
                  nik: (routeSettings.arguments as Map)['nik'] as String,
                  pemilu: (routeSettings.arguments as Map)['pemilu'] as Pemilu,
                );
              });
            default:
              return MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: DView.empty('404 Not Found'),
                ),
              );
          }
        },
      ),
    );
  }
}
