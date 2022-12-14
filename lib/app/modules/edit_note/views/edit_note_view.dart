import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_note_controller.dart';
import '../../../data/models/note_model.dart';
import '../../home/controllers/home_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  EditNoteView({Key? key}) : super(key: key);
  final homeC = Get.find<HomeController>();
  final Note _note = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.titleC.text = _note.title!;
    controller.descriptionC.text = _note.description!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.titleC,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextField(
            autocorrect: false,
            controller: controller.descriptionC,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.isTrue
                  ? null
                  : () async {
                      bool response = await controller.editNote(_note.id!);
                      if (response == true) {
                        await homeC.getAllNotes();
                        Get.back();
                      }
                    },
              child:
                  Text(controller.isLoading.isFalse ? 'Edit Note' : 'Loading'),
            ),
          ),
        ],
      ),
    );
  }
}
