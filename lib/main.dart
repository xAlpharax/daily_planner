import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

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

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // Instantiate the ThemeController using Get.put to make it globally available
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        title: 'Flutter GetX Theme Demo',
        theme: ThemeData.light(), // Light theme
        darkTheme: ThemeData.dark(), // Dark theme
        themeMode: themeController.isDarkTheme.value ? ThemeMode.dark : ThemeMode.light, // ternary go brr
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}

class HomeScreen extends StatelessWidget {
  // Access the ThemeController
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Planner'),
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
    );
  }
}

// this is cool

//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.

// also cool

//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       darkTheme: ThemeData.dark(useMaterial3: true),
//       home: const MyHomePage(title: 'Daily Planner'),