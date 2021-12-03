import 'package:campuschool/screens/Category/categoryScreen.dart';
import 'package:campuschool/screens/Search/searchScreen.dart';
import 'package:campuschool/screens/home/home.dart';
import 'package:campuschool/screens/landingScreen.dart';
import 'package:campuschool/screens/login/loginPage.dart';
import 'package:campuschool/screens/profile/profileScreen.dart';
import 'package:campuschool/screens/splash/splashScreen.dart';
import 'package:campuschool/test.dart';
import 'package:campuschool/test_webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'binding/bindings.dart';
import 'screens/add_class/addClassScreen.dart';
import 'screens/classroom/class_room_screen.dart';
import 'screens/detail/detail_screen.dart';
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
        GetPage(
          name: "/landing/home/addClass",
          page: () => AddClassScreen(),
          binding: AddClassBinding(),
        ),
        GetPage(
          name: "/landing/home/detailScreen",
          page: () => DetailScreen(),
        ),
        GetPage(
          name: "/landing/home/categoryScreen",
          page: () => CategoryScreen(),
          binding: CategoryBinding(),
        ),
        GetPage(
          name: "/landing/classroom/class_room_screen",
          page: () => ClassRoomScreen(),
        ),

      ]
    );
  }
}
