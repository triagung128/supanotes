import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../home/controllers/home_controller.dart';

class EditNoteController extends GetxController {
  final _client = Supabase.instance.client;
  final _homeC = Get.find<HomeController>();

  final titleC = TextEditingController();
  final descriptionC = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> editNote(int id) async {
    if (titleC.text.isNotEmpty && descriptionC.text.isNotEmpty) {
      isLoading.value = true;

      await _client.from('notes').update({
        'title': titleC.text,
        'description': descriptionC.text,
      }).match({'id': id});

      isLoading.value = false;

      Get.back();

      Get.snackbar(
        'Success',
        'Successfully updated data',
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
