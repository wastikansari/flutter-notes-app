import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/api/auth_api.dart';
import 'package:notes_app/screen/authentication/core/component/app_text_field.dart';
import 'package:notes_app/screen/authentication/core/theme/app_color.dart';
import 'package:notes_app/screen/notes_screen.dart';
import 'package:notes_app/utiles/app_constants.dart';
import 'package:notes_app/widget/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool ishidesPassword = true;
  bool ishidesConform = true;
  bool isLoading = false;

  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void registrations() async {
    String name = userController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty) {
      Get.snackbar("Name", "Please enter your name");
    } else if (email.isEmpty) {
      Get.snackbar("Email", "Please enter your email address");
    } else if (!GetUtils.isEmail(email)) {
      Get.snackbar("Valid email", "Please enter your valid email address");
    } else if (password.isEmpty) {
      Get.snackbar("Password", "Please enter your password");
    } else if (password.length < 4) {
      Get.snackbar("Password", "Passsword can't be less than 4 characters");
    } else if (confirmPassword.isEmpty) {
      Get.snackbar("ConfirmPassword", "Enter your confirm password");
    } else if (password != confirmPassword) {
      Get.snackbar(
          "Confirm Password", "The password confirmation does not match");
    } else {
      Registration registration = Registration();
      setState(() {
        isLoading = true;
      });

      await registration.createUser(name, email, password).then((value) async {
        setState(() {
          isLoading = true;
        });

        if (value.status == true) {
          String token = value.token.toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(AppConstants.TOKEN, token);

          setState(() {
            isLoading = false;
          });
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return const NotesScreen();
          }), ((route) => false));
        } else {
          setState(() {
            isLoading = false;
          });
          Get.snackbar("Login", value.message.toString());
        }
      });
 
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColor.blackGrey,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          extendBodyBehindAppBar: true,
          body: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            :
          
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                bottom: MediaQuery.of(context).padding.bottom,
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
                      height: 230,
                      fit: BoxFit.contain,
                      image: const AssetImage("assets/image/img_register.png"),
                    ),
                    Text(
                      "Register",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 20),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppTextField(
                          controller: userController,
                          prefix: Icon(Icons.person_outline),
                          hint: "Username",
                          textInputAction: TextInputAction.done,
                        ),
                        SizedBox(height: 24),
                        AppTextField(
                          controller: emailController,
                          prefix: Icon(Icons.alternate_email_rounded),
                          hint: "Email Address",
                          textInputAction: TextInputAction.done,
                        ),
                        SizedBox(height: 24),
                        AppTextField(
                          controller: passwordController,
                          obscureText: ishidesPassword,
                          prefix: Icon(Icons.lock_outline_rounded),
                          suffix: IconButton(
                              onPressed: (() {
                                setState(() {
                                  ishidesPassword = !ishidesPassword;
                                });
                              }),
                              icon: ishidesPassword
                                  ? const Icon(Icons.visibility_off_outlined)
                                  : const Icon(Icons.remove_red_eye_outlined)),
                          hint: "Password",
                          textInputAction: TextInputAction.done,
                        ),
                        SizedBox(height: 24),
                        AppTextField(
                          controller: confirmPasswordController,
                          obscureText: ishidesConform,
                          prefix: Icon(Icons.lock_outline_rounded),
                          suffix: IconButton(
                              onPressed: (() {
                                setState(() {
                                  ishidesConform = !ishidesConform;
                                });
                              }),
                              icon: ishidesConform
                                  ? const Icon(Icons.visibility_off_outlined)
                                  : const Icon(Icons.remove_red_eye_outlined)),
                          hint: "confirm Password",
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                      text: 'Register',
                      onPressed: () {
                        registrations();
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
