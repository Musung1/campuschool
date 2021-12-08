import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/model/class_model.dart';
import 'package:campuschool/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  static UserController instance = Get.find();
  var userList = <kUser>[].obs;
  RxBool isLiked = false.obs;

  @override
  void onInit() {
    userList.bindStream(getUsers());
    super.onInit();
  }

  List<kUser> uidTokUserConverter(List uid){
    return uid.map((value)=>userList.where((element)=>element.uid ==value).single).toList();
  }
  addLikedClass(String likedClass){
    var k = firebaseFirestore.collection("user").snapshots().map((value)=>
    value.docs.where((value)=>value.data()["uid"] == auth.currentUser!.uid)
        .first
    );
    k.first.then((value)=>
        value.reference.update({
          'likedClass': FieldValue.arrayUnion([likedClass]),
        }));
  }

  addTakedClass(String takedClass){
    var k = firebaseFirestore.collection("user").snapshots().map((value)=>
    value.docs.where((value)=>value.data()["uid"] == auth.currentUser!.uid)
        .first
    );
    k.first.then((value)=>
        value.reference.update({
      'takedClass': FieldValue.arrayUnion([takedClass]),
    }));
  }

  addMyClass(String myClass){
    var k = firebaseFirestore.collection("user").snapshots().map((value)=>
    value.docs.where((value)=>value.data()["uid"] == auth.currentUser!.uid)
        .first
    );
    k.first.then((value)=>
        value.reference.update({
          'myClass': FieldValue.arrayUnion([myClass]),
        }));
  }
  Stream<List<kUser>> getUsers() {
    return firebaseFirestore.collection("user")
        .snapshots().map((value){
      return value.docs.map((element){
        return kUser.fromMap(element.data());
      }
      ).toList();
    });
  }
}