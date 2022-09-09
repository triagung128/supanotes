import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';
import 'app/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Supabase supabase = await Supabase.initialize(
    url: 'https://oxqyygxnjowludvxqdon.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im94cXl5Z3huam93bHVkdnhxZG9uIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjIzNjk1MDksImV4cCI6MTk3Nzk0NTUwOX0.hXK017mpaEI7NxgTqjWfFWBvM3r28m-R0Imd9lKjS8c',
  );

  if (kDebugMode) print(supabase.client.auth.session());

  Get.put(AuthController(), permanent: true);

  runApp(
    GetMaterialApp(
      title: "Supanotes",
      debugShowCheckedModeBanner: false,
      initialRoute:
          supabase.client.auth.currentUser == null ? Routes.login : Routes.home,
      getPages: AppPages.routes,
    ),
  );
}
