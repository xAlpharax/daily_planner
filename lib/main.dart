import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import 'theme_controller.dart';
import 'home_screen.dart';

// Run Point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,); // Initialize Firebase
  await GetStorage.init(); // Initialize GetStorage
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // Instantiate the ThemeController using Get.put to make it globally available
  final ThemeController themeController = Get.put(ThemeController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        title: 'Daily Planner',
        theme: ThemeData.light(), // Light theme
        darkTheme: ThemeData.dark(), // Dark theme
        themeMode: themeController.isDarkTheme.value ? ThemeMode.dark : ThemeMode.light, // ternary go brr
        home: HomeScreen(),
        // home: Obx(() {
        //   return authController.isLoggedIn.value ? HomeScreen() : LoginScreen();
        // })
        debugShowCheckedModeBanner: false,
      );
    });
  }
}