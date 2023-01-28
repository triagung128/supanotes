import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../routes/app_pages.dart';

class AuthController extends GetxController {
  final _client = Supabase.instance.client;

  Timer? _authTimer;

  Future<void> autoLogout() async {
    if (_authTimer != null) _authTimer!.cancel();

    _authTimer = Timer(
      const Duration(seconds: 3600),
      () async {
        await _client.auth.signOut();
        Get.offAllNamed(Routes.login);
      },
    );

    debugPrint('Running auto logout');
  }

  Future<void> reset() async {
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }

    debugPrint('Auto logout reset');
  }
}
