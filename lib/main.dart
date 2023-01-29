import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';
import 'app/controllers/auth_controller.dart';
import 'app/utils/styles.dart';
import 'key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
  );

  final supabaseClientAuth = Supabase.instance.client.auth;

  Get.put(AuthController(), permanent: true);

  runApp(
    GetMaterialApp(
      title: "Supanotes",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
        appBarTheme: appBarTheme,
        inputDecorationTheme: inputDecorationTheme,
        textSelectionTheme: textSelectionThemeData,
        elevatedButtonTheme: elevatedButtonThemeData,
        progressIndicatorTheme: progressIndicatorThemeData,
        floatingActionButtonTheme: floatingActionButtonThemeData,
      ),
      initialRoute:
          supabaseClientAuth.currentUser == null ? Routes.login : Routes.home,
      getPages: AppPages.routes,
    ),
  );
}
