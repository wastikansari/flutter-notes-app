import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/api/auth_api.dart';
import 'package:notes_app/screen/authentication/core/component/app_text_field.dart';
import 'package:notes_app/screen/authentication/core/theme/app_color.dart';
import 'package:notes_app/screen/authentication/forgot_password_screen.dart';
import 'package:notes_app/screen/authentication/register_screen.dart';
import 'package:notes_app/screen/notes_screen.dart';
import 'package:notes_app/utiles/app_constants.dart';
import 'package:notes_app/widget/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool ishides = true;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isLoading = false;

  void _login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty && password.isEmpty) {
      Get.snackbar("Login", "Please enter your email & password");
    }
    if (email.isEmpty) {
      Get.snackbar("Login", "Please enter your email address");
    } else if (!GetUtils.isEmail(email)) {
      Get.snackbar("Email", "Please enter your valid email address");
    } else if (password.isEmpty) {
      Get.snackbar("Password", "Please enter your password");
    } else {
      print('_login $email and $password');
      Registration registration = Registration();
      setState(() {
        isLoading = true;
      });
      await registration.loginUser(email, password).then((value) async {
        setState(() {
          isLoading = true;
        });
        print(value.status);
        if (value.status == true) {
          String token = value.token.toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(AppConstants.TOKEN, token);

          setState(() {
            isLoading = false;
          });
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
          body: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            :
          
          
           Padding(
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
                    image: const AssetImage("assets/image/img_login.png"),
                  ),
                  Text(
                    "Login",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        controller: emailController,
                        prefix: const Icon(Icons.alternate_email_rounded),
                        hint: "Email Address",
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 24),
                      AppTextField(
                        controller: passwordController,
                        obscureText: ishides,
                        prefix: const Icon(Icons.lock_outline_rounded),
                        suffix: IconButton(
                            onPressed: (() {
                              setState(() {
                                ishides = !ishides;
                              });
                            }),
                            icon: ishides
                                ? const Icon(Icons.visibility_off_outlined)
                                : const Icon(Icons.remove_red_eye_outlined)),
                        hint: "Password",
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () {
                  //       Get.to(ForgotPasswordScreen());
                  //     },
                  //     child: const Text("Forgot Password ?"),
                  //   ),
                  // ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      _login();
                    },
                  ),

                  const SizedBox(height: 25),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text("OR"),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an Account ? ",
                            style: Theme.of(context).textTheme.button,
                          ),
                          TextSpan(
                            text: "Register here!",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: AppColor.primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(RegisterScreen());
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
