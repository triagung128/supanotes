import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../routes/app_pages.dart';

class AuthController extends GetxController {
  Timer? authTimer;

  final SupabaseClient _client = Supabase.instance.client;

  Future<void> autoLogout() async {
    if (authTimer != null) authTimer!.cancel();

    authTimer = Timer(
      const Duration(seconds: 3600),
      () async {
        await _client.auth.signOut();
        Get.offAllNamed(Routes.login);
      },
    );

    if (kDebugMode) print('Running auto logout');
  }

  Future<void> reset() async {
    if (authTimer != null) {
      authTimer!.cancel();
      authTimer = null;
    }

    if (kDebugMode) print('Auto logout reset');
  }
}
