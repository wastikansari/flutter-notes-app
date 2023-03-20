import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/routes/routes.dart';
import 'package:notes_app/screen/settings/account.dart';
import 'package:notes_app/screen/settings/dark_mode.dart';
import 'package:notes_app/screen/settings/widgets/list_tile.dart';
import 'package:notes_app/widget/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 21, 98, 231),
        centerTitle: true,
        title: const CustomText(
          text: 'Settings',
          size: 20,
          weight: FontWeight.w500,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ListTileSetting(
                onTap: () {
                  Get.to(() => Account());
                },
                title: "Account",
                iconData: Icons.person,
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              // ListTileSetting(
              //   onTap: () {
              //     Get.to(() => DarkMode());
              //   },
              //   title: "Dark Mode",
              //   iconData: Icons.nights_stay,
              // ),
              ListTileSetting(
                onTap: () {
                  showSignOutDialog(context);
                },
                title: "Logout",
                iconData: Icons.power_settings_new_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSignOutDialog(BuildContext context) async {
    print("in dialog ");
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          actionsPadding: EdgeInsets.only(right: 60),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          title: Text(
            "Are you sure you want to logout?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Your notes are already saved so when logging back your noteswill be there.',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);

                  print('Logout');

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  print(
                      ' isn ${prefs.remove('token')} and ${prefs.remove('token')}');
                  prefs.remove('token');
                  prefs.remove('tokentypof');

                  Get.offAllNamed(Routes.introScreen);
                },
                child: const CustomText(
                  text: 'Logout',
                  size: 18,
                  color: Colors.red,
                  weight: FontWeight.w400,
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const CustomText(
                  text: 'Cancle',
                  size: 18,
                  color: Colors.blue,
                  weight: FontWeight.w400,
                )),
          ],
        );
      },
    );
  }
}
