import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  RxBool isPasswordHidden = true.obs;
  RxBool isLoading = false.obs;

  final SupabaseClient _client = Supabase.instance.client;

  Future<bool?> signIn() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;
      GotrueSessionResponse response = await _client.auth.signIn(
        email: emailC.text,
        password: passwordC.text,
      );
      isLoading.value = false;

      if (response.error == null) {
        if (kDebugMode) {
          print(response.data?.toJson());
        }

        return true;
      } else {
        Get.snackbar('Terjadi kesalahan', response.error!.message);
      }
    } else {
      Get.snackbar('Terjadi kesalahan', 'Email atau Password masih kosong');
    }
    return null;
  }
}
