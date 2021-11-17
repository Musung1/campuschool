import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading:IconButton(
          icon:Icon(Icons.person),
          onPressed:(){
            Get.toNamed('/landing/home/profile');
          }
        ),
        actions:[
          IconButton(
            icon:Icon(Icons.search),
              onPressed:(){
                Get.toNamed('/landing/home/search');
              }
          ),
        ],
        title:Text("캠퍼스쿨"),
      ),
    );
  }
}
