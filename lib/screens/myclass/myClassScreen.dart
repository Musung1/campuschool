import 'package:campuschool/themes/color_theme.dart';
import 'package:campuschool/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyClassScreen extends StatelessWidget {
  const MyClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("내 클래스"),
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _header("수강중인 클래스"),
          Center(child: Text("수강중인 클래스가 없습니다."),),
          SizedBox(height: 340,),
          _addClassButton(),
        ],
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