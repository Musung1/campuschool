import 'package:campuschool/themes/color_theme.dart';
import 'package:campuschool/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Get.toNamed('/landing/home/profile');
            }),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Get.toNamed('/landing/home/search');
              }),
        ],
        title: Text("캠퍼스쿨"),
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _banner(),
          _categoryList(),
          _header("우리 캠퍼스안! 클래스"),
        ],
      ),
    );
  }

  Widget _banner() {
    return Container(
      color: MyColor.primary[200],
      width: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "우리 학교에서\n기타 선생님 찾기",
              style: MyTextStyle.buttonText
                  .copyWith(fontWeight: FontWeight.bold, color: MyColor.white),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "나만의 악기선생님 모음집",
                    style: MyTextStyle.buttonText.copyWith(
                        fontWeight: FontWeight.w400, color: MyColor.white),
                  ),
                ),
                Icon(
                  Icons.music_note_rounded,
                  color: MyColor.white,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryList() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _category(Icon(Icons.mic_external_on), "보컬"),
              _category(Icon(Icons.music_note), "악기"),
              _category(Icon(Icons.lunch_dining), "요리"),
              _category(Icon(Icons.directions_run), "운동"),
            ],
          ),
          SizedBox(height: 32,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _category(Icon(Icons.personal_video), "코딩"),
              _category(Icon(Icons.camera_alt), "촬영"),
              _category(Icon(Icons.accessibility_new), "운동"),
              _category(Icon(Icons.star), "인기"),
            ],
          ),
        ],
      )),
    );
  }

  Widget _category(Icon icon, String name) {
    return GestureDetector(
      child: Column(
        children: [
          icon,
          SizedBox(height: 8,),
          Text(
            name,
            style: MyTextStyle.buttonText.copyWith(fontWeight: FontWeight.w700, fontSize: 14, color: MyColor.darkSub),
          )
        ],
      ),
    );
  }
  Widget _header(String headerName){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(headerName,
              style: MyTextStyle.buttonText.copyWith(fontWeight: FontWeight.w900, fontSize: 18, ),
            ),
          ),
          Icon(Icons.keyboard_arrow_right, color: MyColor.darkSub, size: 32,),
        ],
      ),
    );
  }
  // Widget _classesGrid(){
  //   return GridView
  // }
}
