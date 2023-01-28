import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final _client = Supabase.instance.client;
  final _authC = Get.find<AuthController>();

  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  RxBool isPasswordHidden = true.obs;
  RxBool isLoading = false.obs;
  RxString lastLogin = '-'.obs;

  Future<void> getProfile() async {
    final response = await _client.from('users').select('name, email').match({
      'uid': _client.auth.currentUser!.id,
    });

    final user = (response as List).first as Map<String, dynamic>;

    nameC.text = user['name'];
    emailC.text = user['email'];

    String lastSignInAt = _client.auth.currentUser!.lastSignInAt!;
    String dateFormat =
        DateFormat.yMMMEd().add_jms().format(DateTime.parse(lastSignInAt));

    lastLogin.value = dateFormat;
  }

  Future<void> logout() async {
    await _client.auth.signOut();
    await _authC.reset();
    Get.offAllNamed(Routes.login);
  }

  Future<void> updateProfile() async {
    if (nameC.text.isNotEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();

      isLoading.value = true;

      await _client.from('users').update({
        'name': nameC.text,
      }).match({
        'uid': _client.auth.currentUser!.id,
      });

      // apakah update password
      if (passwordC.text.isNotEmpty) {
        if (passwordC.text.length >= 6) {
          try {
            await _client.auth.updateUser(
              UserAttributes(password: passwordC.text),
            );
          } catch (error) {
            Get.snackbar('Error', error.toString());
          }
        } else {
          Get.snackbar(
            'Cannot change password',
            'Password must be more than 6 characters!',
          );
        }
      }

      isLoading.value = false;

      Get.snackbar('Success', 'Profile data updated successfully');
    } else {
      Get.snackbar('Warning', 'The field input cannot be empty!');
    }
  }
}
