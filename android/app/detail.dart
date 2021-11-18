import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/models/classModel.dart';
import 'package:campuschool/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Detail extends StatelessWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Class product = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title : Text("DETAIL"),
        body : StreamBuilder<Class>(
            stream: getClass(product.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Class hotel = snapshot.data!;
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
                    Text(
                      hotel.price,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(height: 3.0),
                    const Divider(
                      color: Colors.green,
                      thickness: 3,
                      height: 8,
                    ),
                    Text(
                      hotel.description,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 10),
                    ),
                    const Divider(
                      color: Colors.green,
                      thickness: 3,
                      height: 8,
                    ),
                    Column(
                        children : [
                          Text("creator = ${product.author}"),
                        ]
                    ),
                  ],
                );
              } else
                return CircularProgressIndicator();
            }),
      ),
    );
  }
}
Stream<Class> getClass(String id) {
  return firebaseFirestore.collection("class").doc(id).snapshots().map(
        (item) => Class(
  );
}