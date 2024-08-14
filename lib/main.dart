import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import 'theme_controller.dart';
import 'login_screen.dart';
import 'home_screen.dart';

// Run Point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,); // Initialize Firebase
  FirebaseFirestore.instance.settings = const Settings( // Initialize Cloud Firestore
    persistenceEnabled: true,
  );
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    // ... other providers like google, github, etc
  ]);
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
        home: const AuthenticationWrapper(), // HomeScreen(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if user is already logged in
    final user = FirebaseAuth.instance.currentUser;
    // print('Logged in as: ${user?.email}'); // AYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY
    if (user != null) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}