import 'package:get/get.dart';
import 'package:notes_app/screen/add_note_screen.dart';
import 'package:notes_app/screen/authentication/register_screen.dart';
import 'package:notes_app/screen/intro_screen.dart';
import 'package:notes_app/screen/notes_screen.dart';
import 'package:notes_app/screen/settings/setting.dart';
import 'package:notes_app/screen/splash_screen.dart';
import '../screen/authentication/login_screen.dart';


abstract class Routes {
  // splash
  static const String splashScreen = "/";
  //authentication route
  static const String introScreen = "/intro";
  static const String loginScreen = "/login";
  static const String registerScreen = "/register";
  // feacher
  static const String notesScreen = "/notes";
  static const String addNoteScreen = "/addNote";
  static const String editNoteScreen = "/editNote";

  static const String settingScreen = "/setting";

}

class RouteHelper {
  static List<GetPage> routes = [
    // Splash Screen
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),
    // Auth Screen
    GetPage(
      name: Routes.introScreen,
      page: () => const IntroScreen(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
    ),
       GetPage(
      name: Routes.registerScreen,
      page: () => const RegisterScreen(),
    ),
        GetPage(
      name: Routes.notesScreen,
      page: () => const NotesScreen(),
    ),
      GetPage(
      name: Routes.addNoteScreen,
      page: () =>  AddNoteScreen(),
    ),
          GetPage(
      name: Routes.settingScreen,
      page: () =>  SettingScreen(),
    ),

  ];
}
