import 'package:campuschool/controller/assignment_controller.dart';
import 'package:campuschool/model/class_model.dart';
import 'package:campuschool/themes/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeAssignmentScreen extends StatelessWidget {
  const MakeAssignmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Class product = Get.arguments[0];
    bool isStudent = Get.arguments[1];
    AssignmentController assignmentController =
        Get.put(AssignmentController(product));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.primary[600],
        title: Text("${product.name} 과제 만들기"),
        centerTitle: true,
      ),
      floatingActionButton: ElevatedButton.icon(
          icon: Icon(Icons.add),
          onPressed: () {
            assignmentController.setAssignment(product.id);
            assignmentController.name.clear();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Colors.orange),
          ),
          label: Text("과제 생성")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              cursorColor: MyColor.primary,
              controller: assignmentController.name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "과제를 입력하세요",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
