import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  const AddNoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
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
                  : () async => await controller.addNote(),
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
