

import 'dart:io';

import 'package:campuschool/constants/firebaseConstants.dart';
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
  TextEditingController name = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController history = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("클래스 개설하기"),
        centerTitle: true,
        actions: [TextButton(child: Text("완료", style: MyTextStyle.buttonText.copyWith(color: MyColor.white)),
          onPressed: (){
            addProductToFirebase(
                name.text, price.text, category.text, date.text, description.text,  _image!.path, history.text);
            uploadFile();
            Get.back();
        },)],
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
            Row(
              children: [
                Expanded(child: Container()),
                IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () {
                      chooseFile();
                    }),
              ],
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
              controller: date,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "기간",
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

  Future chooseFile() async {
    await _picker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = File(image!.path);
      });
    });
  }

  addProductToFirebase(String name, String price, String category, String date, String desc, String filename, String history) {
    FirebaseFirestore.instance.collection("class").add(<String, dynamic>{
      'author': auth.currentUser!.uid,
      'name': name,
      'price': price,
      'category' : category,
      'desc': desc,
      'date' : date,
      'createdTime': Timestamp.now(),
      'modifiedTime': Timestamp.now(),
      'liked': false,
      'history' : history,
      'image': filename,
      'location' : history,
      'likes': 100,
    });
  }

  Future uploadFile() async {
    Reference storageReference = firebaseStorage
        .ref()
        .child('product/${_image!.path}.jpeg');
    Task uploadTask = storageReference.putFile(_image!);
    await uploadTask.then((res) => res.ref.getDownloadURL());
  }
}
