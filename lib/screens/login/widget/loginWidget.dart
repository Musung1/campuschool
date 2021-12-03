import 'package:campuschool/constants/controllerConstants.dart';
import 'package:campuschool/themes/color_theme.dart';
import 'package:campuschool/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';


Widget googleLoginButton() => Padding(
  padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
  child:   ElevatedButton(
    onPressed: () {
      authController.loginWithGoogle();
    }, child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.recommend,color: MyColor.white,),
      Text("    구글로 시작하기",  style: MyTextStyle.buttonText.copyWith(color: MyColor.white, fontWeight: FontWeight.bold)),
    ],
  ),
    style: ButtonStyle(
      backgroundColor:  MaterialStateProperty.all<Color>(Colors.pinkAccent),
    ),
  ),
);

Widget guestLogin() => Padding(
  padding: const EdgeInsets.fromLTRB(32.0, 16, 32, 0),
  child:   ElevatedButton(
    onPressed: () {
      authController.loginWithGoogle();
    }, child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.accessibility_new,color: MyColor.white,),
        Text("    게스트 시작하기",  style: MyTextStyle.buttonText.copyWith(color: MyColor.white, fontWeight: FontWeight.bold)),
      ],
    ),
    style: ButtonStyle(
      backgroundColor:  MaterialStateProperty.all<Color>(Colors.orange),
    ),
  ),
);
