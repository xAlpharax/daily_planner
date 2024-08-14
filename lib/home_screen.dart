import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:intl/intl.dart';

import 'theme_controller.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Access the ThemeController
  final ThemeController themeController = Get.find();

  // Access the Cloud Firestore for task list data
  final CollectionReference _tasks = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('tasks'); // AUTH GO BRR

  void _addOrEditTask([DocumentSnapshot? documentSnapshot]) {
    final TextEditingController taskNameController = TextEditingController();
    final TextEditingController taskDescriptionController = TextEditingController();
    DateTime? dueDate = DateTime.now(); // Set default due date to right now
    String? priority = 'Normal'; // Set default priority of tasks to be Normal

    DateTime? createdAt;

    if (documentSnapshot != null) {
      taskNameController.text = documentSnapshot['name'];
      taskDescriptionController.text = documentSnapshot['description'];
      dueDate = (documentSnapshot['due_date'] as Timestamp).toDate();
      priority = documentSnapshot['priority'];
      createdAt = (documentSnapshot['created_at'] as Timestamp).toDate();
    } else {
      createdAt = DateTime.now();
    }

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(documentSnapshot == null ? 'New Task' : 'Edit Task'),
              content: SingleChildScrollView(
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
                      controller: taskDescriptionController,
                      decoration: const InputDecoration(labelText: 'Description'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(dueDate == null ? 'No Due Date Chosen' : 'Due Date: ${DateFormat.yMd('fr_FR').format(dueDate!)}'),
                        ),
                        TextButton(
                          child: const Text('Select Date'),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: dueDate ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                dueDate = pickedDate;
                              });
                            }
                          }
                      )
                    ],
                  ),
                  DropdownButton<String>(
                    value: priority,
                    hint: const Text('Select Priority'),
                    items: ['Critical', 'Normal', 'Low'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      priority = value;
                    });
                  },
                ),
                if (documentSnapshot != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Created At: ${DateFormat.yMd('fr_FR').add_jm().format(createdAt!)}',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
            ],
          ),
        ),
        actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(documentSnapshot == null ? 'Add' : 'Update'),
              onPressed: () async {
                if (true) {
                  // Handle form submission here
                  final String name = taskNameController.text;
                  final String description = taskDescriptionController.text;
                  print('Task Name: $name');
                  print('Description: $description');

                  if (name.isNotEmpty && description.isNotEmpty && priority != null && dueDate != null) {
                    if (documentSnapshot == null) {
                      await _tasks.add({
                        "name": name,
                        "description": description,
                        "created_at": Timestamp.fromDate(DateTime.now()),
                        "due_date": Timestamp.fromDate(dueDate!),
                        "priority": priority,
                        "is_done": false
                      });
                    } else {
                      await _tasks.doc(documentSnapshot.id).update({
                        "name": name,
                        "description": description,
                        "created_at": Timestamp.fromDate(DateTime.now()),
                        // Update the creation date
                        "due_date": Timestamp.fromDate(dueDate!),
                        "priority": priority,
                      });
                    }
                    Navigator.of(context).pop();
                    taskNameController.clear();
                    taskDescriptionController.clear();
                  }
                }
                },
            ),
        ],
        );
      },
    );
  },
  );
  }

  void _deleteTask(String taskId) {
    _tasks.doc(taskId).delete();
  }

  void _toggleDoneStatus(DocumentSnapshot documentSnapshot) {
    _tasks.doc(documentSnapshot.id).update({
      "is_done": !documentSnapshot['is_done'],
    });
  }

int _getPriorityValue(String priority) {
  switch (priority) {
    case 'Critical':
      return 1;
    case 'Normal':
      return 2;
    case 'Low':
      return 3;
    default:
      return 2;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log Out',
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
      body: StreamBuilder(
        stream: _tasks.orderBy('priority').orderBy('created_at', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            print("Data received: ${streamSnapshot.data!.docs.length} tasks found.");
            List<DocumentSnapshot> unfinishedTasks = [];
            List<DocumentSnapshot> finishedTasks = [];

            for (var task in streamSnapshot.data!.docs) {
              if (task['is_done']) {
                finishedTasks.add(task);
              } else {
                unfinishedTasks.add(task);
              }
            }

            unfinishedTasks.sort((a, b) {
              return _getPriorityValue(a['priority'])
                  .compareTo(_getPriorityValue(b['priority']));
            });

            finishedTasks.sort((a, b) {
              return _getPriorityValue(a['priority'])
                  .compareTo(_getPriorityValue(b['priority']));
            });

            List<DocumentSnapshot> sortedTasks = [
              ...unfinishedTasks,
              ...finishedTasks
            ];

            Color? isDoneColor = themeController.isDarkTheme.value ? Colors.black26 : Colors.grey[300];

            return ListView.builder(
              itemCount: sortedTasks.length, // streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = sortedTasks[index]; // streamSnapshot.data!.docs[index];
                final dueDate = (documentSnapshot['due_date'] as Timestamp).toDate();
                return Card(
                  margin: const EdgeInsets.all(10),
                  color: documentSnapshot['is_done'] ? isDoneColor : null,
                  child: ListTile(
                    title: Text(
                      documentSnapshot['name'],
                      style: TextStyle(decoration: documentSnapshot['is_done'] ? TextDecoration.lineThrough : TextDecoration.none),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(documentSnapshot['description']),
                        Text('Due Date: ${DateFormat.yMd('fr_FR').format(dueDate)}'),
                      ],
                    ),
                    onTap: () => _addOrEditTask(documentSnapshot),
                    trailing: SizedBox(
                      width: 75, // PERFECT
                      child: Row(
                        children: [
                          Flexible(
                            child: Checkbox(
                              value: documentSnapshot['is_done'],
                              onChanged: (_) => _toggleDoneStatus(documentSnapshot),
                            ),
                          ),

                          // Flexible(
                          //   child: IconButton( // You can add this back if requested, I find it cluttering the cards for no reason
                          //     icon: const Icon(Icons.edit),
                          //     tooltip: 'Edit',
                          //     onPressed: () => _addOrEditTask(documentSnapshot),
                          //   ),
                          // ),

                          Flexible(
                            child: IconButton(
                              icon: const Icon(Icons.delete),
                              tooltip: 'Delete',
                              onPressed: () => _deleteTask(documentSnapshot.id),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (streamSnapshot.hasError) {
            print("Error: ${streamSnapshot.error}");
            return Center(child: Text("An error occurred: ${streamSnapshot.error}"));
          } return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditTask(),
        tooltip: 'Add New Task',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
  }

  void requestNotificationPermission() async {

    if (await Permission.notification.status.isGranted) {
      print('Notification permission has been already granted.');
      // Notifications can be sent

      // Let s get the token for a mock notification:
      final fcmToken = await FirebaseMessaging.instance.getToken(); // THIS REFRESHES FOR EACH APP INSTALLATION
      print("$fcmToken");

    }
    else {
      PermissionStatus status = await Permission.notification.request();
      // After requesting, you ll need to have it run in the background manually
      // Never mind, it doesn't need anything manual, it s just my notification preferences
      // So it should be alright just saying yes to notifications and it should all work fine

      if (status.isGranted) {
        print('Notification permission granted.');
        // Notifications can now be sent

        // Let s get the token for a mock notification:
        final fcmToken = await FirebaseMessaging.instance.getToken(); // THIS REFRESHES FOR EACH APP INSTALLATION
        print("$fcmToken");

      } else if (status.isDenied) {
        print('Notification permission denied. No token for you.');
        // Optionally open app settings
        // openAppSettings();
      }
    }
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