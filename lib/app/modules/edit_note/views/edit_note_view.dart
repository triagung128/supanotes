import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/note_model.dart';
import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  EditNoteView({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.titleC,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            minLines: 1,
            maxLines: null,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'Input Title',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            autocorrect: false,
            controller: controller.descriptionC,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            minLines: 5,
            maxLines: null,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Input Description',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 48),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.isTrue
                  ? null
                  : () async => await controller.editNote(_note.id!),
              child: Text(
                controller.isLoading.isFalse ? 'Save' : 'Loading',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
