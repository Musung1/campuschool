import 'dart:ffi';
import 'dart:io';
import 'package:campuschool/constants/controllerConstants.dart';
import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/constants/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddClassController extends GetxController {
  static AddClassController instance = Get.find();
  final ImagePicker picker = ImagePicker();
  late XFile pickedImage;
  Rx<String> imageName = ''.obs;
  late double latitude;
  late double longitude;
  TextEditingController name = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController history = TextEditingController();
  Category selectedValue = Category.vocal;


  Future<void> uploadFile() async {
    File file = File(pickedImage.path);
    await firebase_storage.FirebaseStorage.instance
        .ref('$imageName.jpeg').putFile(file);
  }

  Future<void> pickImg() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
        pickedImage = image;
        imageName.value = Uuid().v4();

    }
  }
  Future addClassToFirebase() async{
    await firebaseFirestore.collection("class").add(<String, dynamic>{
      'author': auth.currentUser!.uid,
      'name': name.text,
      'price': price.text,
      'category': category.text,
      'date': date.text,
      'description': description.text,
      'image': imageName.value,
      'location': location.text,
      'history': history.text,
      'latitude' : latitude,
      'longitude' : longitude,
    }).then((value) => userController.addMyClass(value.id));
  }
  Future<String> downloadURL() async {
    String downloadURL = await firebaseStorage
        .ref('${imageName}.jpeg')
        .getDownloadURL();
    return downloadURL;
  }
}
