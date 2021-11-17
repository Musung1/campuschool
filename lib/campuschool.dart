import 'package:campuschool/screens/Search/searchScreen.dart';
import 'package:campuschool/screens/home/home.dart';
import 'package:campuschool/screens/landingScreen.dart';
import 'package:campuschool/screens/login/loginPage.dart';
import 'package:campuschool/screens/profile/profileScreen.dart';
import 'package:campuschool/screens/splash/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'binding/bindings.dart';
class Campuschool extends StatelessWidget {
  const Campuschool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(
        name: "/",
        page: () => SplashScreen(),
        ),
        GetPage(
          name: "/login",
          page: () => LoginScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: "/landing",
          page: () => LandingScreen(),
          binding: LandingBinding(),
        ),
        GetPage(
          name: "/landing/home",
          page: () => Home(),
        ),
        GetPage(
          name: "/landing/home/profile",
          page: () => ProfileScreen(),
        ),
        GetPage(
          name: "/landing/home/search",
          page: () => SearchScreen(),
        ),
      ]
    );
  }
}
