import 'dart:io';
import 'package:campuschool/autoComplete.dart';
import 'package:campuschool/constants/controllerConstants.dart';
import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/test.dart';
import 'package:campuschool/themes/color_theme.dart';
import 'package:campuschool/themes/text_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddClassScreen extends StatefulWidget {
  const AddClassScreen({Key? key}) : super(key: key);

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {

  String dropdownvalue = 'vocal';
  var items =  ['vocal','instrument','cook','exercise','coding','filming','dance','popular'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColor.primary,
          title: Text("클래스 개설하기", style: MyTextStyle.centerTitle.copyWith(color: MyColor.white),),
          centerTitle: true,
          actions: [
            TextButton(
              child: Text("완료",
                  style: MyTextStyle.buttonText.copyWith(color: MyColor.white)),
              onPressed: () {
                addClassController.addClassToFirebase();
                addClassController.uploadFile();
                Get.back();
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("클래스 대표 사진", style: MyTextStyle.buttonText.copyWith(fontWeight: FontWeight.bold, color: MyColor.primary),),
              ),
              Container(
                height: 200,
                child: Center(
                  child: Obx(()=>
                    addClassController.imageName.value == ''?
                      Image.asset(
                        "assets/img/default.png",
                        fit: BoxFit.cover,
                      ):
                        Image.file(File(addClassController.pickedImage.path)),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  IconButton(
                      icon: const Icon(Icons.camera_alt), onPressed: () {
                        addClassController.pickImg();
                  }),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("클래스 이름", style: MyTextStyle.buttonText.copyWith(fontWeight: FontWeight.bold, color: MyColor.primary),),
              ),
              TextFormField(
                cursorColor: MyColor.primary,
                controller: addClassController.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "클래스 이름",
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("클래스 장소", style: MyTextStyle.buttonText.copyWith(fontWeight: FontWeight.bold, color: MyColor.primary),),
              ),
              TextFormField(
                onTap: () {
                  Get.to(AuthComplete());
                },
                controller: addClassController.location,
                readOnly: true,
                cursorColor: MyColor.primary,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "장소",
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("클래스 종류", style: MyTextStyle.buttonText.copyWith(fontWeight: FontWeight.bold, color: MyColor.primary),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  value: dropdownvalue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                        value: items,
                        child: Expanded(child: Text(items, style: MyTextStyle.buttonText.copyWith(color: MyColor.primary[300]),))
                    );
                  }
                  ).toList(),
                  onChanged: (String? newValue){
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                    addClassController.category.text = newValue!;
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("클래스 설명", style: MyTextStyle.buttonText.copyWith(fontWeight: FontWeight.bold, color: MyColor.primary),),
              ),
              TextFormField(
                cursorColor: MyColor.primary,
                controller: addClassController.description,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "클래스 설명",
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("클래스 가격", style: MyTextStyle.buttonText.copyWith(fontWeight: FontWeight.bold, color: MyColor.primary),),
              ),
              TextFormField(
                cursorColor: MyColor.primary,
                controller: addClassController.price,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "가격",
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("클래스 기간", style: MyTextStyle.buttonText.copyWith(fontWeight: FontWeight.bold, color: MyColor.primary),),
              ),
              TextFormField(
                cursorColor: MyColor.primary,
                controller: addClassController.date,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "기간",
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("캠티 약력", style: MyTextStyle.buttonText.copyWith(fontWeight: FontWeight.bold, color: MyColor.primary),),
              ),
              TextFormField(
                cursorColor: MyColor.primary,
                controller: addClassController.history,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "캠티 약력",
                ),
              ),
            ],
          ),
        ));
  }
}
