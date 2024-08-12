import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

// Run Point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,); // Initialize Firebase
  await GetStorage.init(); // Initialize GetStorage
  runApp(MyApp());
}

// Controller for managing the theme mode
class ThemeController extends GetxController {
  // Use GetStorage to persist theme data
  final GetStorage _box = GetStorage();
  final String _key = 'isDarkTheme';

  // RxBool for tracking whether the dark theme is enabled
  var isDarkTheme = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Load the theme from storage or use the default theme (light)
    isDarkTheme.value = _loadThemeFromBox();
  }

  // Load the theme from GetStorage
  bool _loadThemeFromBox() {
    return _box.read(_key) ?? false; // Return false if the key doesn't exist
  }

  // Save the theme to GetStorage and toggle the theme
  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    _saveThemeToBox(isDarkTheme.value);
  }

  // Save the theme preference to GetStorage
  void _saveThemeToBox(bool isDarkTheme) {
    _box.write(_key, isDarkTheme);
  }
}

class MyApp extends StatelessWidget {

  // Instantiate the ThemeController using Get.put to make it globally available
  final ThemeController themeController = Get.put(ThemeController());

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

class HomeScreen extends StatelessWidget {
  // Access the ThemeController
  final ThemeController themeController = Get.find();

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Information',
            onPressed: () {
              // Action for info button
              _showPopupInfoForm(context);
              print('Info button pressed');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              // Action for settings button
              _showPopupSettingsForm(context);
              print('Settings button pressed');
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Toggle the theme when the button is pressed
            themeController.toggleTheme();
          },
          child: Obx(() => Text(
              themeController.isDarkTheme.value ? 'Switch to Light Theme' : 'Switch to Dark Theme')),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { _showPopupNewTaskForm(context); },
        tooltip: 'Add new task',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showPopupNewTaskForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: taskNameController,
                  decoration: const InputDecoration(labelText: 'Task Name'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle form submission here
                print('Task Name: ${taskNameController.text}');
                print('Description: ${descriptionController.text}');
                // You can also close the dialog after submission
                Navigator.of(context).pop();
                taskNameController.clear();
                descriptionController.clear();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showPopupSettingsForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Settings'),
          content: ElevatedButton(
            onPressed: () {
              // Toggle the theme when the button is pressed
              themeController.toggleTheme();
            },
            child: Obx(() => Text(
                themeController.isDarkTheme.value ? 'Switch to Light Theme' : 'Switch to Dark Theme')),
          ),
        );
      }
    );
  }

  void _showPopupInfoForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Info'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text('Made by: xAlpharax')
              ],
            ),
          )
        );
      }
    );
  }
  
}