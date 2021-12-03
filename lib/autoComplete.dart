import 'package:campuschool/constants/controllerConstants.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';
class AuthComplete extends StatefulWidget {
  const AuthComplete({Key? key}) : super(key: key);

  @override
  _AuthCompleteState createState() => _AuthCompleteState();
}

class _AuthCompleteState extends State<AuthComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KpostalView(
        useLocalServer: true,
        localPort: 1024,
        // kakaoKey: '{Add your KAKAO DEVELOPERS JS KEY}',
        callback: (Kpostal result) {
            addClassController.location.text = result.address;
            addClassController.latitude = result.latitude!;
            addClassController.longitude = result.longitude!;
        },
      ),
    );
  }
}
