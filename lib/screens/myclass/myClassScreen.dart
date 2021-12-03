import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/themes/color_theme.dart';
import 'package:campuschool/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class MyClassScreen extends StatelessWidget {
  const MyClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.primary,
        title: Text("내 클래스", style: MyTextStyle.centerTitle.copyWith(color: MyColor.white),),
        centerTitle: true,
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _userDesc(),
          _header("수강중인 클래스"),
          Center(child: Text("수강중인 클래스가 없습니다."),),
          SizedBox(height: 300,),
          _addClassButton(),
        ],
      ),
    );
  }
  Widget _userDesc(){
    return Container(
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
    );
  }
  Widget _addClassButton() {
    return ElevatedButton.icon(
        onPressed: () {
          Get.toNamed("/landing/home/addClass");
        },
        icon: Icon(Icons.add),
        label: Text("클래스 개설하기"));
  }

  Widget _header(String headerName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(headerName,
              style: MyTextStyle.buttonText.copyWith(
                fontWeight: FontWeight.w900, fontSize: 18,),
            ),
          ),
        ],
      ),
    );
  }
}