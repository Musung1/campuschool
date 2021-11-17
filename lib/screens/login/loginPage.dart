import 'package:campuschool/screens/login/widget/loginWidget.dart';
import 'package:campuschool/themes/text_theme.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
          SizedBox(height: 200,),
          Center(
            child: Container(
              child: Column(
                children: [
                  Text("캠퍼스쿨", style: MyTextStyle.logoText,),
                  Text("캠퍼스 안, 당신의 새로운 학교"),
                ],
              ),
            ),
          ),
          SizedBox(height: 200,),
          googleLoginButton(),
        ],
      ),
    );
  }
}
