import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/styles.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SUPANOTES'),
        titleTextStyle: appBarTextStyle.copyWith(fontWeight: FontWeight.w900),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Sign In',
            style: titleTextStyle,
          ),
          const SizedBox(height: 24),
          TextField(
            textInputAction: TextInputAction.next,
            controller: controller.emailC,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Input Email',
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => TextField(
              textInputAction: TextInputAction.done,
              controller: controller.passwordC,
              autocorrect: false,
              obscureText: controller.isPasswordHidden.isTrue ? true : false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Input Password',
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
          const SizedBox(height: 48),
          Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.isTrue
                  ? null
                  : () async => await controller.signIn(),
              child: Text(
                controller.isLoading.isFalse ? 'Login' : 'Loading...',
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Get.offNamed(Routes.register),
            child: Text(
              'Sign up with different email',
              style: linkTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
