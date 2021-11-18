import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/models/classModel.dart';
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
          )
        ],
        title:Text("캠퍼스쿨"),
      ),
      body : StreamBuilder<List<Class>>(
          stream: getClass(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Text(snapshot.data!.first.name);
            }
            else return CircularProgressIndicator();
          }),
    );
  }
}
Stream<List<Class>> getClass() {
  return firebaseFirestore.collection("class")
      .snapshots().map((value){
    return value.docs.map((element){
      return Class(
        name : element.data()['name'].toString(),
        category : element.data()['category'].toString(),
        price : element.data()['price'].toString(),
        description : element.data()['description'].toString(),
        location : element.data()['location'].toString(),
        date : element.data()['date'].toString(),
        image : element.data()['image'].toString(),
        author : element.data()['author'].toString(),
      );
    }
    ).toList();
  });
}
