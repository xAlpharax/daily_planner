# Daily Planner

A complete To-Do App made in Flutter for Android, iOS and Web with Firebase.

This app's features:
- Cloud synced todo list in realtime with Firebase Cloud Firestore
- User authentication across supported devices with Firebase Auth
- Each account has its own private data that they authenticate into to view and modify 
- Notifications for reminders to complete the tasks via Firebase Cloud Messaging (opt-in)
- Priority queue task management with lightning fast sync from the CRUD of Cloud Firestore
- Offline app data, you have your tasks persist in the app even if you aren't connected to the internet
- FOSS, it is Free and and Open Source Software with an * asterisk because of Firebase use, otherwise the code is licensed under AGPL
- Cool UI and UX (imho) with Material Design
- Light / Dark mode with getx state management 

Dotenv and every key or stuff shown is deliberate for the project and was requested to be present.

## Installation Instructions

Go to the [Releases](https://github.com/xAlpharax/daily_planner/releases) page of the project and download the `.apk`, then install it. Web is also available. (I'm sorry but for iOS you will have to compile it yourself)

## Demo

https://github.com/user-attachments/assets/8c49eba9-3db8-4758-a8d2-312f689b21ba

## Compiling Instructions

1. Make sure to have the Flutter SDK installed and pointed at by your IDE.
2. Open the repository with your IDE, go to pubspec.yaml and perform `pub get`
3. Select a platform to test the application on.
4. Hit Run.
5. ???
6. Profit.

More simply put:

```bash
# make sure flutter is installed and you can use it in cli like:
#flutter --version

# make sure you are in the appropriate directory `daily_planner`
# the output of pwd should be the project directory `daily_planner`
#pwd

# run pub get
flutter pub get

# you should be able to build these three with no issue
flutter build apk
flutter build ios
flutter build web
```

## Packages used for the App

I have used, as seen in `pubspec.yaml`:

```yaml
# state management
get: ^4.6.6
get_storage: ^2.1.1

# handling requesting device permissions
permission_handler: ^11.3.1

# localization helper for dates and strings
intl: ^0.19.0

# firebase tooling suite
firebase_core: ^3.3.0
firebase_auth: ^5.1.4
firebase_ui_auth: ^1.15.0
cloud_firestore: ^5.2.1
firebase_messaging: ^15.0.4

# pretty app icon on all platforms
flutter_launcher_icons: ^0.13.1
```

## Flutter Installation Versions Info

I have used this flutter installation to have everything running right inside Android Studio:

```bash
alphara@deltarion ~> flutter --version
Flutter 3.24.0 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 80c2e84975 (2 weeks ago) • 2024-07-30 23:06:49 +0700
Engine • revision b8800d88be
Tools • Dart 3.5.0 • DevTools 2.37.2
alphara@deltarion ~>
```

## Contributing

I'm actively supporting FOSS collaboration, so, if you feel like you can help in any way, file an issue in the *Issues* tab or submit a Pull Request and I will go through it.

## License

Copyright (C) xAlpharax

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see https://www.gnu.org/licenses/.

## Images and Graphics

And here I refer to the app images under `assets/`.

[Creative Commons Attribution 4.0 International (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/).
