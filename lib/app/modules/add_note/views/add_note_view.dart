import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_note_controller.dart';
import '../../home/controllers/home_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  AddNoteView({Key? key}) : super(key: key);

  final homeC = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
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
                      bool response = await controller.addNote();
                      if (response == true) {
                        await homeC.getAllNotes();
                        Get.back();
                      }
                    },
              child:
                  Text(controller.isLoading.isFalse ? 'Add Note' : 'Loading'),
            ),
          ),
        ],
      ),
    );
  }
}
