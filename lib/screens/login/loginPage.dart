import 'package:campuschool/screens/login/widget/loginWidget.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children:[
          Text("캠퍼스쿨"),
          Text("캠퍼스 안, 당신의 새로운 학교"),
          googleLoginButton(),
        ],
      ),
    );
  }
}
