import 'package:course_pemilu/config/app_color.dart';
import 'package:course_pemilu/config/app_route.dart';
import 'package:course_pemilu/source/user_source.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(220),
              child: Image.asset(
                'asset/pemilu.png',
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.height * 0.2,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Center(
                    child: Container(
                      height: 5,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  DView.spaceHeight(30),
                  DInput(
                    controller: controllerUsername,
                    hint: 'Username',
                  ),
                  DView.spaceHeight(),
                  DInput(
                    controller: controllerPassword,
                    hint: 'Password',
                  ),
                  DView.spaceHeight(),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        login(context);
                      },
                      child: const Text('Login sebagai Admin'),
                    ),
                  ),
                  DView.spaceHeight(),
                  SizedBox(
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.dashboardUmum);
                      },
                      child: const Text('Login sebagai Umum'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  login(BuildContext context) {
    UserSource.login(controllerUsername.text, controllerPassword.text).then(
      (success) {
        if (success) {
          DInfo.dialogSuccess(context, "Berhasil Login");
          DInfo.closeDialog(context, actionAfterClose: () {
            Navigator.pushNamed(context, AppRoute.dashboardAdmin);
          });
        } else {
          DInfo.dialogError(context, "Gagal Login");
          DInfo.closeDialog(context);
        }
      },
    );
  }
}
