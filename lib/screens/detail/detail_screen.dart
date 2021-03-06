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
                    Container(
                      child: Text(product.name),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: MyColor.darkContainer,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
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
                            children: [
                              Text(
                                "??? 1?????? 2??? 3??????    ",
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
                                "  ??????",
                                style: MyTextStyle.buttonText.copyWith(
                                    color: MyColor.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      classController.classList
                          .where((element) => element.id == product.id)
                          .first
                          .description,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(height: 16.0),
                    Column(children: [
                      Text(
                          "creator = ${classController.classList.where((element) => element.id == product.id).first.author}"),
                    ]),
                    SizedBox(
                      height: 100,
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
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("?????? ????????????")),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
