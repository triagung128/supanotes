import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  RxBool isPasswordHidden = true.obs;
  RxBool isLoading = false.obs;

  final TextEditingController nameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  final SupabaseClient _client = Supabase.instance.client;

  void signUp() async {
    if (nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        passwordC.text.isNotEmpty) {
      isLoading.value = true;
      GotrueSessionResponse response =
          await _client.auth.signUp(emailC.text, passwordC.text);
      isLoading.value = false;

      if (response.error == null) {
        if (kDebugMode) {
          print(response.data?.toJson());
        }

        // insert data user -> table user
        await _client.from('users').insert({
          'email': emailC.text,
          'name': nameC.text,
          'created_at': DateTime.now().toIso8601String(),
          'uid': response.user!.id
        }).execute();

        // tanpa email verfication
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
        Get.snackbar('Terjadi kesalahan', response.error!.message);
      }
    } else {
      Get.snackbar('Terjadi kesalahan', 'Email atau Password masih kosong');
    }
  }
}
