import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/note_model.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/styles.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SUPANOTES'),
        titleTextStyle: appBarTextStyle.copyWith(fontWeight: FontWeight.w900),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.profile),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: FutureBuilder(
        future: controller.getAllNotes(),
        builder: (_, snapshot) {
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
                    padding: const EdgeInsets.all(24),
                    itemBuilder: (_, index) {
                      final Note note = controller.allNotes[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        child: ListTile(
                          onTap: () => Get.toNamed(
                            Routes.editNote,
                            arguments: note,
                          ),
                          onLongPress: () async =>
                              await controller.deleteNote(note.id!),
                          tileColor: whiteColorOpacity75,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              width: 0.5,
                              color: blackColorOpacity75,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          title: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              '${note.title}',
                              style: bodyTextStyle.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            '${note.description}',
                            style: bodyTextStyle,
                          ),
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
