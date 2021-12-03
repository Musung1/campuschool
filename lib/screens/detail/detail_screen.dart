import 'dart:async';

import 'package:campuschool/constants/controllerConstants.dart';
import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/controller/class_controller.dart';
import 'package:campuschool/model/class_model.dart';
import 'package:campuschool/screens/home/home.dart';
import 'package:campuschool/test.dart';
import 'package:campuschool/themes/color_theme.dart';
import 'package:campuschool/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Class product = Get.arguments;
    Completer<GoogleMapController> _controller = Completer();
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(
          double.parse(product.latitude), double.parse(product.longitude)),
      zoom: 18,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.primary[600],
        title: Text(product.name),
        centerTitle: true,
      ),
      body: Obx(() => ListView(
            children: [
              FutureBuilder<String>(
                  future: downloadURLExample(product
                      .image), // a previously-obtained Future<String> or null
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Image.network(snapshot.data!,
                          fit: BoxFit.fitWidth);
                    } else
                      return Container();
                  }),
              const SizedBox(height: 3.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 32,),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(product.name, style: MyTextStyle.buttonText.copyWith(color: MyColor.primary, fontWeight: FontWeight.bold, fontSize: 18)),
                          Text(" 클래스에 오신걸 환영합니다! ", style: MyTextStyle.buttonText.copyWith(color: MyColor.primary[300], fontWeight: FontWeight.bold)),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: MyColor.primary[100],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      padding: EdgeInsets.all(16),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: MyColor.darkContainer,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "가격    ",
                                style: MyTextStyle.buttonText
                                    .copyWith(color: MyColor.white, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "주 1시간 2회 3개월    ",
                                style: MyTextStyle.buttonText
                                    .copyWith(color: MyColor.white),
                              ),
                              Text(
                                classController.classList
                                    .where(
                                        (element) => element.id == product.id)
                                    .first
                                    .price,
                                maxLines: 2,
                                style: MyTextStyle.buttonText
                                    .copyWith(color: MyColor.white),
                              ),
                              Text(
                                "  만원",
                                style: MyTextStyle.buttonText.copyWith(
                                    color: MyColor.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: MyColor.darkSub,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("클래스 설명", style: MyTextStyle.buttonText.copyWith(
                           fontSize: 16, fontWeight: FontWeight.bold)),
                          Divider(
                            indent: 16,
                            endIndent: 16,
                          ),
                          Text(
                            classController.classList
                                .where((element) => element.id == product.id)
                                .first
                                .description,
                            maxLines: 2,
                            style:MyTextStyle.buttonText.copyWith(
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: MyColor.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("캠티 설명", style: MyTextStyle.buttonText.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                          Divider(
                            indent: 16,
                            endIndent: 16,
                          ),
                          Row(
                            children: [
                              Text("ID:   "),
                              Text(
                                classController.classList.where((element) => element.id == product.id).first.author,
                                maxLines: 2,
                                style:MyTextStyle.buttonText.copyWith(
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          Divider(
                            indent: 16,
                            endIndent: 16,
                          ),
                          Row(
                            children: [
                              Text("약력:   "),
                              Text(
                                classController.classList.where((element) => element.id == product.id).first.history,
                                maxLines: 2,
                                style:MyTextStyle.buttonText.copyWith(
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("장소", style:MyTextStyle.buttonText.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold), ),
                        ],
                      ),
                    ),
                    Container(
                      height: Get.height * 0.3,
                      width: Get.width * 0.9,
                      child: GoogleMap(
                        markers: Set.from([
                          Marker(
                              markerId: MarkerId("1"),
                              position: LatLng(double.parse(product.latitude),
                                  double.parse(product.longitude)))
                        ]),
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () {
                          print(auth.currentUser!.uid);
                          print(product.id);
                          userController.addTakedClass(product.id);
                          Get.back();
                        },
                        style: ButtonStyle(
                          backgroundColor:  MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                        ),
                        child: Text("수강 신청하기", style:MyTextStyle.buttonText.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold, color: MyColor.white),)),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
