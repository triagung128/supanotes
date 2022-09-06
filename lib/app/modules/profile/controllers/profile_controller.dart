import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  RxBool isPasswordHidden = true.obs;
  RxBool isLoading = false.obs;
  RxString lastLogin = '-'.obs;

  final TextEditingController nameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  final SupabaseClient _client = Supabase.instance.client;

  Future<void> getProfile() async {
    PostgrestResponse<dynamic> response =
        await _client.from('users').select('name, email').match({
      'uid': _client.auth.currentUser!.id,
    }).execute();

    // (response.data as List)[0]
    Map<String, dynamic> user =
        (response.data as List).first as Map<String, dynamic>;

    nameC.text = user['name'];
    emailC.text = user['email'];

    String lastSignInAt = _client.auth.currentUser!.lastSignInAt!;
    String dateFormat =
        DateFormat.yMMMEd().add_jms().format(DateTime.parse(lastSignInAt));

    lastLogin.value = dateFormat;

    if (kDebugMode) {
      print(response.toJson());
    }
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }

  Future<void> updateProfile() async {
    if (nameC.text.isNotEmpty) {
      isLoading.value = true;
      await _client.from('users').update({
        'name': nameC.text,
      }).match({
        'uid': _client.auth.currentUser!.id,
      }).execute();

      // apakah update password
      if (passwordC.text.isNotEmpty) {
        if (passwordC.text.length >= 6) {
          try {
            await _client.auth.api.updateUser(
              _client.auth.currentSession!.accessToken,
              UserAttributes(password: passwordC.text),
            );
          } catch (error) {
            Get.snackbar('Terjadi Kesalahan', error.toString());
          }
        } else {
          Get.snackbar(
            'Tidak dapat ganti password',
            'Password harus lebih dari 6 karakter',
          );
        }
      }

      isLoading.value = false;

      FocusManager.instance.primaryFocus?.unfocus();
      Get.snackbar('Sukses', 'Data Profile Berhasil Diupdate!');

      // Get.back();
    }
  }
}
