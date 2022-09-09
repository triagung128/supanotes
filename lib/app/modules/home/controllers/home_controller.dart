import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/models/note_model.dart';

class HomeController extends GetxController {
  RxList allNotes = List<Note>.empty().obs;

  final SupabaseClient _client = Supabase.instance.client;

  Future<void> getAllNotes() async {
    PostgrestResponse<dynamic> user =
        await _client.from('users').select('id').match({
      'uid': _client.auth.currentUser!.id,
    }).execute();

    int id = (user.data as List).first['id'];

    var notes = await _client.from('notes').select().match({
      'user_id': id,
    }).execute();

    List<Note> dataNote = Note.fromJsonList(notes.data as List);
    allNotes(dataNote);
    allNotes.refresh();
  }

  void deleteNote(int id) async {
    await _client.from('notes').delete().match({'id': id}).execute();
    await getAllNotes();
  }
}
