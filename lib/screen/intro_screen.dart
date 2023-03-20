import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/routes/routes.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/widget/custom_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "My Notes",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Lottie.asset(
              'assets/lottie/note3.json',
              width: 250,
              height: 250,
            ),
            const Text(
              "Use the Notes app to quickly capture your thoughts, your notes stay up to date on all your devices wherever you go.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromARGB(255, 174, 174, 174), fontSize: 15),
            ),
            CustomButton(
              text: 'Take Notes',
              onPressed: () {
                Get.toNamed(Routes.loginScreen);
              },
            )
          ],
        ),
      ),
    );
  }
}
