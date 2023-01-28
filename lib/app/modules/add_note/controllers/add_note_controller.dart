import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../home/controllers/home_controller.dart';

class AddNoteController extends GetxController {
  final _client = Supabase.instance.client;
  final _homeC = Get.find<HomeController>();

  final titleC = TextEditingController();
  final descriptionC = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> addNote() async {
    if (titleC.text.isNotEmpty && descriptionC.text.isNotEmpty) {
      isLoading.value = true;

      final user = await _client.from('users').select('id').match({
        'uid': _client.auth.currentUser!.id,
      });

      int id = (user as List).first['id'];

      await _client.from('notes').insert({
        'user_id': id,
        'title': titleC.text,
        'description': descriptionC.text,
        'created_at': DateTime.now().toIso8601String(),
      });

      isLoading.value = false;

      Get.back();

      Get.snackbar(
        'Success',
        'Successfully added data',
      );

      await _homeC.getAllNotes();
    } else {
      Get.snackbar(
        'Warning',
        'The field input cannot be empty!',
      );
    }
  }
}
