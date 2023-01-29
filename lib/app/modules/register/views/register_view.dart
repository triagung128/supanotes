import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/styles.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

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
            'Sign Up',
            style: titleTextStyle,
          ),
          const SizedBox(height: 24),
          TextField(
            textInputAction: TextInputAction.next,
            controller: controller.nameC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Input Your Name',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            textInputAction: TextInputAction.next,
            controller: controller.emailC,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Input Your Email Address',
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
                hintText: 'Password Min. 6 Characters',
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
                  : () => controller.signUp(),
              child: Text(
                controller.isLoading.isFalse ? 'Register' : 'Loading...',
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Get.offNamed(Routes.login),
            child: Text(
              'Already have an account? Sign in',
              style: linkTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
