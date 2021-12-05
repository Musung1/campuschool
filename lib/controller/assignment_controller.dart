import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/model/assignment_model.dart';
import 'package:campuschool/model/class_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignmentController extends GetxController{
  final Class product;
  AssignmentController(this.product);
  TextEditingController name = TextEditingController();
  RxList assignments = [].obs;
  void onInit() {
    assignments.bindStream(getAssignments());
    super.onInit();
  }

  setAssignment(String path){
    firebaseFirestore.collection("class").doc(path).
    collection("assignment").add(<String, dynamic>{
      'name': name.text,
      'complete' : [],
      'date' : "a",
    });
  }
  Stream<List<Assignment>> getAssignments() {
    return firebaseFirestore.collection("class")
        .doc(product.id).collection("assignment")
        .snapshots().map((value){
      return value.docs.map((element){
        return Assignment(
          date: element.data()['date'].toString(),
          name : element.data()['name'].toString(),
          complete : element.data()['complete'],
        );
      }
      ).toList();
    });
  }
}