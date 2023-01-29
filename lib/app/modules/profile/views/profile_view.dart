import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/styles.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async => await controller.logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder(
        future: controller.getProfile(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              TextField(
                readOnly: true,
                controller: controller.emailC,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                textInputAction: TextInputAction.done,
                controller: controller.nameC,
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Input Name',
                ),
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 16),
              Text(
                'Last Login : ',
                style: bodyTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Obx(
                () => Text(
                  '${controller.lastLogin}',
                  style: bodyTextStyle,
                ),
              ),
              const SizedBox(height: 48),
              Obx(
                () => ElevatedButton(
                  onPressed: controller.isLoading.isTrue
                      ? null
                      : () async {
                          await controller.updateProfile();
                          if (controller.passwordC.text.isNotEmpty &&
                              controller.passwordC.text.length > 6) {
                            await controller.logout();
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
