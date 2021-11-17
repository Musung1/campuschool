import 'package:campuschool/themes/color_theme.dart';
import 'package:campuschool/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddClassScreen extends StatelessWidget {
  const AddClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController category = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController history = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("클래스 개설하기"),
        centerTitle: true,
        actions: [TextButton(child: Text("완료", style: MyTextStyle.buttonText.copyWith(color: MyColor.white)), onPressed: (){},)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              height: 200,
              child: Center(
                child: Image.asset(
                  "assets/img/default.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8,),
            TextFormField(
              cursorColor: MyColor.primary,
              controller: name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                labelText: "클래스 이름",
              ),
            ),
            SizedBox(height: 16,),
            TextFormField(
              cursorColor: MyColor.primary,
              controller: category,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "클래스 종류",
              ),
            ),
            SizedBox(height: 16,),
            TextFormField(
              cursorColor: MyColor.primary,
              controller: description,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "클래스 설명",
              ),
            ),
            SizedBox(height: 16,),
            TextFormField(
              cursorColor: MyColor.primary,
              controller: price,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "가격",
              ),
            ),
            SizedBox(height: 16,),
            TextFormField(
              cursorColor: MyColor.primary,
              controller: history,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "캠티 약력",
              ),
            ),
          ],
        ),
      )
    );
  }

}
