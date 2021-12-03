import 'package:campuschool/constants/controllerConstants.dart';
import 'package:campuschool/constants/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String category = Get.arguments;
    return Scaffold(
      appBar:AppBar(title:Text(category),),
      body: ListView(
        children: classController.classList.where((element)=>element.category == categoryAdaptor[category]).map((value){
          return Text(value.name);
    }).toList()),
    );
  }
}
