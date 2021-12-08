import 'dart:async';

import 'package:campuschool/constants/controllerConstants.dart';
import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/controller/assignment_controller.dart';
import 'package:campuschool/model/assignment_model.dart';
import 'package:campuschool/model/class_model.dart';
import 'package:campuschool/screens/home/home.dart';
import 'package:campuschool/themes/color_theme.dart';
import 'package:campuschool/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class ClassRoomScreen extends StatefulWidget {
  const ClassRoomScreen({Key? key}) : super(key: key);

  @override
  _ClassRoomScreenState createState() => _ClassRoomScreenState();
}

class _ClassRoomScreenState extends State<ClassRoomScreen> {
  final textDetector = GoogleMlKit.vision.textDetector();

  Future<bool> _recognizeImage() async {
    final inputImage =
        InputImage.fromFilePath(addClassController.pickedImage.path);
    final text = await textDetector.processImage(inputImage);
    if(text.text.length < 100){
      Get.snackbar("제출 실패", "100자 이상 적으세요");
      return false;
    }
    else{
      Get.snackbar("제출 성", "축하합니다.");
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Class product = Get.arguments[0];
    bool isStudent = Get.arguments[1];
    AssignmentController assignmentController =
        Get.put(AssignmentController(product));
    Completer<GoogleMapController> _controller = Completer();
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(
          double.parse(product.latitude), double.parse(product.longitude)),
      zoom: 18,
    );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColor.primary,
          title: Text(product.name),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: '클래스', icon: Icon(Icons.school)),
              Tab(text: '과제', icon: Icon(Icons.book_sharp)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Obx(() => ListView(
                  children: [
                    FutureBuilder<String>(
                        future: downloadURLExample(product.image),
                        // a previously-obtained Future<String> or null
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
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
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("공지사항",
                                    style: MyTextStyle.buttonText.copyWith(
                                        color: MyColor.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                Text(" 오늘 늦지마세요! ",
                                    style: MyTextStyle.buttonText.copyWith(
                                        color: MyColor.primary[300],
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: MyColor.primary[100],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            padding: EdgeInsets.all(16),
                          ),
                          SizedBox(
                            height: 16,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "가격    ",
                                      style: MyTextStyle.buttonText.copyWith(
                                          color: MyColor.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "주 1시간 2회 3개월    ",
                                      style: MyTextStyle.buttonText
                                          .copyWith(color: MyColor.white),
                                    ),
                                    Text(
                                      classController.classList
                                          .where((element) =>
                                              element.id == product.id)
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
                                Text("클래스 설명",
                                    style: MyTextStyle.buttonText.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Divider(
                                  indent: 16,
                                  endIndent: 16,
                                ),
                                Text(
                                  classController.classList
                                      .where(
                                          (element) => element.id == product.id)
                                      .first
                                      .description,
                                  maxLines: 2,
                                  style: MyTextStyle.buttonText
                                      .copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
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
                                Text("캠티 설명",
                                    style: MyTextStyle.buttonText.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Divider(
                                  indent: 16,
                                  endIndent: 16,
                                ),
                                Row(
                                  children: [
                                    Text("ID:   "),
                                    Text(
                                      classController.classList
                                          .where((element) =>
                                              element.id == product.id)
                                          .first
                                          .author,
                                      maxLines: 2,
                                      style: MyTextStyle.buttonText
                                          .copyWith(fontSize: 16),
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
                                      classController.classList
                                          .where((element) =>
                                              element.id == product.id)
                                          .first
                                          .history,
                                      maxLines: 2,
                                      style: MyTextStyle.buttonText
                                          .copyWith(fontSize: 16),
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
                                Text(
                                  "장소",
                                  style: MyTextStyle.buttonText.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
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
                                    position: LatLng(
                                        double.parse(product.latitude),
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
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                )),
            // 내가 선생이면 공지사항 수정, 과제 내줄 수 있음
            // 과제 내주기 + 과제 확인 가능
            // 수강생들 확인
            // 학생이면 과제 제출
            if (isStudent)
              ListView(
                children: [
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: assignmentController.assignments
                            .map(
                              (value) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: MyColor.primary[100],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(child: Text(value.name, style: MyTextStyle.buttonText,)),
                                            Obx(() {
                                              if(userController.userList.isNotEmpty){
                                                if(userController.uidTokUserConverter(value.complete).map((value) => value.uid).toList().contains(auth.currentUser!.uid))
                                                  return Text("제출완료  ",
                                                    style: MyTextStyle.buttonText
                                                        .copyWith(fontSize: 15),);
                                                else return Text("제출하기  ",
                                                  style: MyTextStyle.buttonText
                                                      .copyWith(fontSize: 15),);
                                              }
                                              else return Text("제출  ",
                                                style: MyTextStyle.buttonText
                                                    .copyWith(fontSize: 15),);
                                            }
                                            ),
                                            Icon(Icons.camera_alt)
                                          ],
                                        )),
                                    onTap: () {
                                      addClassController
                                          .pickImg()
                                          .then((v) => _recognizeImage().then((element){
                                        assignmentController.addComplete(
                                            auth.currentUser!.uid, value);
                                      }));
                                    }),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              )
            else
              Scaffold(
                floatingActionButton: ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Get.toNamed('/make_assignment/make_assignment_screen',
                          arguments: [product, isStudent]);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                    ),
                    label: Text("과제내기")),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Obx(
                        () => Column(
                          children: assignmentController.assignments
                              .map(
                                (value) => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: MyColor.darkContainer,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text("  과제명: ${value.name}",
                                                    style: MyTextStyle
                                                        .buttonText
                                                        .copyWith(
                                                            color:
                                                                MyColor.white)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    "  완료자 현황: ${userController.uidTokUserConverter(value.complete).map((value) => value.name).toList().toString()}",
                                                    style: MyTextStyle
                                                        .buttonText
                                                        .copyWith(
                                                            color:
                                                                MyColor.white)),
                                              ],
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
