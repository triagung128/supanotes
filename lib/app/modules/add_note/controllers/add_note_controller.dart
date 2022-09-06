import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddNoteController extends GetxController {
  final TextEditingController titleC = TextEditingController();
  final TextEditingController descriptionC = TextEditingController();

  final SupabaseClient _client = Supabase.instance.client;

  RxBool isLoading = false.obs;

  Future<bool> addNote() async {
    if (titleC.text.isNotEmpty && descriptionC.text.isNotEmpty) {
      isLoading.value = true;
      PostgrestResponse<dynamic> user =
          await _client.from('users').select('id').match({
        'uid': _client.auth.currentUser!.id,
      }).execute();

      int id = (user.data as List).first['id'];

      await _client.from('notes').insert({
        'user_id': id,
        'title': titleC.text,
        'description': descriptionC.text,
        'created_at': DateTime.now().toIso8601String(),
      }).execute();
      isLoading.value = false;

      return true;
    } else {
      return false;
    }
  }
}
