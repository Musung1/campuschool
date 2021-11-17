import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 2500),
      (() async {
        Get.offNamed("/login");
      }),
    );
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Image.asset(
          'assets/gif/plu.gif',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

