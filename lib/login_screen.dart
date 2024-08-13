import 'package:flutter/material.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'package:get/get.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SignInScreen(
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          Get.offAll(() => HomeScreen());

          // can easily implement email verifying
          // if (!state.user!.isEmailVerified) {
          //   Navigator.pushNamed(context, '/verify-email');
          // } else {
          //   Navigator.pushReplacementNamed(context, '/profile');
          // }
        }),
      ],
    );
  }
}