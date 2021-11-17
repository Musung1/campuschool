import 'package:campuschool/constants/controllerConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

Widget googleLoginButton() => SignInButton(
      Buttons.Google,
      onPressed: () {
        authController.loginWithGoogle();
      },
    );
