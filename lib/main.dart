import 'package:easy_learn_teacher/core/shared/color.dart';
import 'package:easy_learn_teacher/view/screen/auth/Login.dart';
import 'package:easy_learn_teacher/view/screen/profile/edit_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'controller/middleware/auth_middleware.dart';
import 'firebase_options.dart';
import 'view/screen/auth/Signup.dart';
import 'view/screen/layout.dart';
import 'view/screen/profile/Privacy_Policy.dart';
import 'view/screen/profile/helper_screen/layout_help_screen.dart';
import 'view/screen/profile/lang.dart';
import 'view/screen/profile/notification.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Teacher App ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Tajawal',
        colorScheme: ColorScheme.fromSeed(seedColor: ProjectColors.mainColor),
        useMaterial3: true,
      ),
      // home: AddProject(teacherId: ''),
      initialRoute:'/Login',
      getPages: [
        GetPage(name: '/Login', page: () => Login()  , middlewares: [AuthMiddleware()] ),
        GetPage(name: '/signup', page: () => Signup()),
        GetPage(name: '/Layout', page: () => Layout()),
        GetPage(name: '/EditProfile', page: () => EditProfile()),
        GetPage(name: '/Notifications', page: () => Notifications()),
        GetPage(name: '/PrivacyPolicy', page: () => PrivacyPolicy()),
        GetPage(name: '/Lang', page: () => Lang()),
        GetPage(name: '/LayoutHelpScreen', page: () => LayoutHelpScreen()),
      ],
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale("ar", "AE")],
      locale: Locale("ar", "AL"),
    );
  }
}
