import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';
import 'app/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://oxqyygxnjowludvxqdon.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im94cXl5Z3huam93bHVkdnhxZG9uIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzQ4OTA0MzcsImV4cCI6MTk5MDQ2NjQzN30.6Agl4NLdPU5EQikYtVl5JD55fcZWR69f-fC_ydFEG0E',
  );

  final supabaseClientAuth = Supabase.instance.client.auth;

  Get.put(AuthController(), permanent: true);

  runApp(
    GetMaterialApp(
      title: "Supanotes",
      debugShowCheckedModeBanner: false,
      initialRoute:
          supabaseClientAuth.currentUser == null ? Routes.login : Routes.home,
      getPages: AppPages.routes,
    ),
  );
}
