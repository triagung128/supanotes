import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/models/note_model.dart';

class HomeController extends GetxController {
  final _client = Supabase.instance.client;

  RxList allNotes = List<Note>.empty().obs;

  Future<void> getAllNotes() async {
    final user = await _client.from('users').select('id').match({
      'uid': _client.auth.currentUser!.id,
    });

    final id = (user as List).first['id'] as int;

    final notes = await _client.from('notes').select().match({
      'user_id': id,
    }).order('id', ascending: false);

    final dataNote = Note.fromJsonList(notes as List);
    allNotes(dataNote);
    allNotes.refresh();
  }

  Future<void> deleteNote(int id) async {
    await _client.from('notes').delete().match({'id': id});
    await getAllNotes();
  }
}
