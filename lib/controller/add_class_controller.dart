import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddClassController extends GetxController{

  final ImagePicker picker = ImagePicker();
  late XFile pickedImage;
  late String imageName;

  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);
    imageName = Uuid().v4();
    await firebase_storage.FirebaseStorage.instance
        .ref('${imageName}.jpg').putFile(file);

  }

  Future<void> pickImg() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // setState(() {
      //   pickedImage = image;
      //   isPicked = true;
      // });
    }
  }
}