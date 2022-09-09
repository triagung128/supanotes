import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  final _authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await controller.logout();
              await _authC.reset();
              Get.offAllNamed(Routes.login);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder(
        future: controller.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              TextField(
                readOnly: true,
                controller: controller.emailC,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                textInputAction: TextInputAction.done,
                controller: controller.nameC,
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Obx(
                () => TextField(
                  textInputAction: TextInputAction.done,
                  controller: controller.passwordC,
                  autocorrect: false,
                  obscureText:
                      controller.isPasswordHidden.isTrue ? true : false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () => controller.isPasswordHidden.toggle(),
                      icon: Icon(
                        controller.isPasswordHidden.isTrue
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Last Login : ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Obx(
                () => Text('${controller.lastLogin}'),
              ),
              const SizedBox(
                height: 32.0,
              ),
              Obx(
                () => ElevatedButton(
                  onPressed: controller.isLoading.isTrue
                      ? null
                      : () async {
                          await controller.updateProfile();
                          if (controller.passwordC.text.isNotEmpty &&
                              controller.passwordC.text.length > 6) {
                            await controller.logout();
                            await _authC.reset();
                            Get.offAllNamed(Routes.login);
                          }
                        },
                  child: Text(
                    controller.isLoading.isFalse
                        ? 'Update Profile'
                        : 'Loading...',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
