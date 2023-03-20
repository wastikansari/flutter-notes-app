
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:notes_app/screen/authentication/core/component/app_text_field.dart';
import 'package:notes_app/screen/authentication/core/theme/app_color.dart';
import 'package:notes_app/screen/authentication/reset_password_screen.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.only(
          //top: MediaQuery.of(context).padding.top,
          //bottom: MediaQuery.of(context).padding.bottom,
          left: 24,
          right: 24,
          
        ),
        child: SingleChildScrollView(
        reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                width: MediaQuery.of(context).size.width,
                height: 400,
                fit: BoxFit.contain,
                image: const AssetImage("asset/images/img_forgot_password.png"),
              ),
                SizedBox(height: 24),
              Text(
                "Forgot\nPassword",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
                const SizedBox(height: 24),
              Text(
                "Don't worry! It happens. Please enter the email that associated with yout Account.",
                style: Theme.of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: Colors.grey),
              ),
                const SizedBox(height: 24),
              const SizedBox(),
              const AppTextField(
                prefix: Icon(Icons.alternate_email_rounded),
                hint: "Email Address",
                textInputAction: TextInputAction.done,
              ),
                const SizedBox(height: 44),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                   Get.to(const ResetPassword());
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  child: const Text("Submit"),
                ),
              ),
               const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
