import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  final _client = Supabase.instance.client;

  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  RxBool isPasswordHidden = true.obs;
  RxBool isLoading = false.obs;

  Future<void> signUp() async {
    if (nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        passwordC.text.isNotEmpty) {
      isLoading.value = true;

      final response = await _client.auth.signUp(
        email: emailC.text,
        password: passwordC.text,
      );

      // insert data user -> table user
      await _client.from('users').insert({
        'email': emailC.text,
        'name': nameC.text,
        'created_at': DateTime.now().toIso8601String(),
        'uid': response.user!.id
      });

      isLoading.value = false;

      // without email verfication
      Get.offAllNamed(Routes.home);

      // jika ada fitur email verification
      // Get.defaultDialog(
      //   barrierDismissible: false, // agar tidak bisa dismiss
      //   title: 'Berhasil Register!',
      //   middleText:
      //       'Periksa dan lakukan verifikasi email. Kami telah mengirimkan email verifikasi ke email yang telah anda daftarkan.',
      //   actions: [
      //     OutlinedButton(
      //       onPressed: () {
      //         Get.back(); // tutup dialog
      //         Get.back(); // kembali ke halaman login
      //       },
      //       child: const Text('Ya saya mengerti'),
      //     ),
      //   ],
      // );
    } else {
      Get.snackbar('Warning', 'The field input cannot be empty!');
    }
  }
}
