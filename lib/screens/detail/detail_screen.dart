import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/model/class_model.dart';
import 'package:campuschool/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Class product = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title : Text(product.name),
        centerTitle: true,
      ),
        body : StreamBuilder<Class>(
            stream: getClass(product.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Class data = snapshot.data!;
                return ListView(
                  children: [
                    FutureBuilder<String>(
                        future: downloadURLExample(product.image), // a previously-obtained Future<String> or null
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Image.network(snapshot.data!,
                                fit: BoxFit.fitWidth);
                          }

                          else
                            return const CircularProgressIndicator();
                        }),
                    const SizedBox(height: 3.0),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("주 1시간 2회 3개월 ", style: const TextStyle(fontSize: 16),),
                              Text(
                                data.price,
                                maxLines: 2,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            data.description,
                            maxLines: 2,
                            style: const TextStyle(fontSize: 10),
                          ),
                          const SizedBox(height: 16.0),
                          Column(
                              children : [
                                Text("creator = ${data.author}"),
                              ]
                          ),
                          SizedBox(height: 100,),
                          ElevatedButton(onPressed: (){Get.back();}, child: Text("수강 신청하기"))
                        ],
                      ),
                    ),


                  ],
                );
              } else
                return CircularProgressIndicator();
            }),
      );
  }
}
Stream<Class> getClass(String id) {
  return firebaseFirestore.collection("class").doc(id).snapshots().map(
          (element) => Class(
              name : element.data()!['name'].toString(),
              category : element.data()!['category'].toString(),
              price : element.data()!['price'].toString(),
              description : element.data()!['description'].toString(),
              location : element.data()!['location'].toString(),
              date : element.data()!['date'].toString(),
              image : element.data()!['image'].toString(),
              author : element.data()!['author'].toString(),
              id : element.id.toString()
          )
  );
}