import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

import '../../config/app_route.dart';

class InputNikPage extends StatelessWidget {
  const InputNikPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerNik = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: DView.appBarCenter('Input NIK'),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DInput(
              controller: controllerNik,
              hint: 'Masukkan NIK',
              validator: (value) => value == '' ? 'Jangan kosong' : null,
            ),
            DView.spaceHeight(),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pushNamed(
                    context,
                    AppRoute.pilihPemilu,
                    arguments: controllerNik.text,
                  );
                }
              },
              child: const Text('Lanjut'),
            ),
          ],
        ),
      ),
    );
  }
}
