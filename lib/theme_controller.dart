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