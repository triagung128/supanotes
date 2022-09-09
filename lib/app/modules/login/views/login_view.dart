import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final _authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            textInputAction: TextInputAction.next,
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
          Obx(
            () => TextField(
              textInputAction: TextInputAction.done,
              controller: controller.passwordC,
              autocorrect: false,
              obscureText: controller.isPasswordHidden.isTrue ? true : false,
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
          ElevatedButton(
            onPressed: controller.isLoading.isTrue
                ? null
                : () async {
                    bool? cekLogin = await controller.signIn();
                    if (cekLogin == true) {
                      await _authC.autoLogout();
                      Get.offAllNamed(Routes.home);
                    }
                  },
            child: Text(
              controller.isLoading.isFalse ? 'Login' : 'Loading...',
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextButton(
            onPressed: () => Get.toNamed(Routes.register),
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
