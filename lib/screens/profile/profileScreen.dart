import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/themes/color_theme.dart';
import 'package:campuschool/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("내 프로필",
            style: MyTextStyle.centerTitle.copyWith(color: MyColor.white),),
        backgroundColor: MyColor.primary[600],
      ),
      body: Column(
        children: [
          _userDesc(),
          Text("춤 • 악기 • 코딩", style: MyTextStyle.buttonText.copyWith(color: MyColor.darkSub)),
          SizedBox(height: 16,),
          ElevatedButton(onPressed: (){},
              child: Text("프로필 편집"),
            style: ButtonStyle(
              backgroundColor:  MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
            ),),
        ],
      ),
    );
  }

  Widget _userDesc(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: Get.height*0.15,
        color: MyColor.primary[200],
        padding: const EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: Image.network(
                        currentUser!.photoURL.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(auth.currentUser!.displayName.toString(), style: MyTextStyle.buttonText.copyWith(color: MyColor.white, fontWeight: FontWeight.w900),),
                      Text(auth.currentUser!.email.toString(), style: MyTextStyle.buttonText.copyWith(color: MyColor.white, fontWeight: FontWeight.w500, fontSize: 14),),
                    ],
                  )
                ],
              ),

            ]
        ),
      ),
    );
  }
}
