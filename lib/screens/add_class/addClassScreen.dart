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
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddClassScreen extends StatefulWidget {
  const AddClassScreen({Key? key}) : super(key: key);

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  final textDetector = GoogleMlKit.vision.textDetector();
  void _recognizeEmails() async {

    final inputImage = InputImage.fromFilePath(addClassController.pickedImage.path);
    final text = await textDetector.processImage(inputImage);
    print(text.text);
    print(text.text.length);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("클래스 개설하기"),
          centerTitle: true,
          actions: [
            TextButton(
              child: Text("완료",
                  style: MyTextStyle.buttonText.copyWith(color: MyColor.white)),
              onPressed: () {
                _recognizeEmails();
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
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
            ],
          ),
        ));
  }
}
