import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/screen/authentication/core/theme/app_color.dart';
import 'package:notes_app/utiles/app_constants.dart';
import 'package:notes_app/widget/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/routes.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
         _checkLogedIn();
    });
  }

    void _checkLogedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final tkn = prefs.getString(AppConstants.TOKEN);
    if (tkn != null && tkn.isNotEmpty) {
      Get.offAllNamed(Routes.notesScreen);
    } else {
      Get.offAllNamed(Routes.introScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/note.png',
              height: 110,
            ),
            const SizedBox(
              height: 20,
            ),
             CustomText(
              text: 'My Notes',
              color: AppColor.primaryColor,
              size: 16,
              weight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
