import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

import 'package:get/get.dart';

import 'theme_controller.dart';
import 'login_screen.dart';
import 'database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Access the ThemeController
  final ThemeController themeController = Get.find();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  Stream?taskStream;

  getOnTheLoad () async {
    taskStream = await DatabaseService().getTask("Tasks");
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getOnTheLoad();
    super.initState();
  }

  Widget getTasks () {
    return StreamBuilder(
      stream: taskStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Expanded(
          child: ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
              // return CheckboxListTile(
              //   title: Text(documentSnapshot['todo']),
              //   value: suggest,
              //   onChanged: (newValue) {
              //     setState(() {
              //       suggest = newValue!;
              //     });
              //   },
              // );
              return Scaffold(
                body: Text(documentSnapshot['todo']),
              );
            },
          ),
        );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.offAll(() => const LoginScreen());
            },
          ),
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
      // body: Column(
      //   children: [
      //     getTasks(),
      //   ]
      // ),
      body: Center(
        child: getTasks()
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

    final formKey = GlobalKey<FormState>();

    final user = FirebaseAuth.instance.currentUser;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Task'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: taskNameController,
                    decoration: const InputDecoration(labelText: 'Task Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field should not be empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                ],
              ),
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
                if (formKey.currentState!.validate()) {
                  // Handle form submission here
                  // print('Task Name: ${taskNameController.text}');
                  // print('Description: ${descriptionController.text}');
                  // You can also close the dialog after submission

                  // HANDLING FORM SUBMIT:
                  String id = "${user?.uid}";
                  Map<String, dynamic> userTodo = {
                    "todo": taskNameController.text,
                    "Id": id,
                  };

                  DatabaseService().addTask(userTodo, id);
                  // WHAT THIS DID IS CHANGE THE SAME STRING EACH TIME
                  // WHY? because we haven t managed it yet
                  Navigator.of(context).pop();
                  taskNameController.clear();
                  descriptionController.clear();
                }
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
    final user = FirebaseAuth.instance.currentUser;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Info'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text('App made by: xAlpharax'),
                    const Text('You are logged in as:'),
                    Text("${user?.email}")
                  ],
                ),
              )
          );
        }
    );
  }
}