import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/note_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.profile),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: FutureBuilder(
        future: controller.getAllNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Obx(
            () => controller.allNotes.isEmpty
                ? const Center(
                    child: Text('Data is empty'),
                  )
                : ListView.builder(
                    itemCount: controller.allNotes.length,
                    itemBuilder: (context, index) {
                      Note note = controller.allNotes[index];
                      return ListTile(
                        onTap: () => Get.toNamed(
                          Routes.editNote,
                          arguments: note,
                        ),
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text('${note.title}'),
                        subtitle: Text('${note.description}'),
                        trailing: IconButton(
                          onPressed: () => controller.deleteNote(note.id!),
                          icon: const Icon(Icons.delete),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.addNote),
        child: const Icon(Icons.add),
      ),
    );
  }
}
