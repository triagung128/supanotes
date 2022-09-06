import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditNoteController extends GetxController {
  final TextEditingController titleC = TextEditingController();
  final TextEditingController descriptionC = TextEditingController();

  final SupabaseClient _client = Supabase.instance.client;

  RxBool isLoading = false.obs;

  Future<bool> editNote(int id) async {
    if (titleC.text.isNotEmpty && descriptionC.text.isNotEmpty) {
      isLoading.value = true;
      await _client.from('notes').update({
        'title': titleC.text,
        'description': descriptionC.text,
      }).match({'id': id}).execute();
      isLoading.value = false;

      return true;
    } else {
      return false;
    }
  }
}
