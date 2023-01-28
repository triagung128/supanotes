import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final _client = Supabase.instance.client;
  final _authC = Get.find<AuthController>();

  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  RxBool isPasswordHidden = true.obs;
  RxBool isLoading = false.obs;

  Future<void> signIn() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;

      try {
        await _client.auth.signInWithPassword(
          email: emailC.text,
          password: passwordC.text,
        );

        await _authC.autoLogout();

        isLoading.value = false;

        Get.offAllNamed(Routes.home);
      } on AuthException catch (e) {
        isLoading.value = false;

        Get.snackbar('Error', e.message);
      }
    } else {
      Get.snackbar('Warning', 'The field input cannot be empty!');
    }
  }
}
