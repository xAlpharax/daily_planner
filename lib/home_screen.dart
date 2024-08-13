import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_controller.dart';

class HomeScreen extends StatelessWidget {
  // Access the ThemeController
  final ThemeController themeController = Get.find();

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  HomeScreen({super.key});

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
              // print('Info button pressed');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              // Action for settings button
              _showPopupSettingsForm(context);
              // print('Settings button pressed');
            },
          ),
        ],
      ),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       // Toggle the theme when the button is pressed
      //       themeController.toggleTheme();
      //     },
      //     child: Obx(() => Text(
      //         themeController.isDarkTheme.value ? 'Switch to Light Theme' : 'Switch to Dark Theme')),
      //   ),
      // ),
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
                // print('Task Name: ${taskNameController.text}');
                // print('Description: ${descriptionController.text}');
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
          return const AlertDialog(
              title: Text('Info'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Made by: xAlpharax'),
                    // Text('d') // will add a Signed in as: $email that is signed in as.
                  ],
                ),
              )
          );
        }
    );
  }

}