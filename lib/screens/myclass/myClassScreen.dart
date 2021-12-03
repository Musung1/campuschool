import 'package:campuschool/constants/controllerConstants.dart';
import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/model/class_model.dart';
import 'package:campuschool/model/user_model.dart';
import 'package:campuschool/themes/color_theme.dart';
import 'package:campuschool/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class MyClassScreen extends StatelessWidget {
  const MyClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.primary,
        title: Text(
          "내 클래스",
          style: MyTextStyle.centerTitle.copyWith(color: MyColor.white),
        ),
        centerTitle: true,
      ),
      body: _bodyWidget(),
      floatingActionButton: _addClassButton(),
    );
  }

  Widget _bodyWidget() {
    kUser currentUser = userController.userList
        .where((value) => value.uid == auth.currentUser!.uid)
        .first;
    classController.takedClasses.value = currentUser.takedClass
        .map((value) => classController.classList
            .where((element) => element.id == value)
            .first)
        .toList();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _userDesc(),
          _header("수강중인 클래스"),
          Obx(
            () => classController.takedClasses.isBlank!
                ? Text("현재 수강중인 클래스가 없습니다.")
                :
                Container(
                  height: 260,
                  child: ListView(
                  children:
                    _buildGridCards(classController.takedClasses),
                  ),
                )

          ),
          _header("강의중인 클래스"),
          Center(
            child: Text("강의중인 클래스가 없습니다."),
          ),
          SizedBox(
            height: 280,
          ),
        ],
      ),
    );
  }

  Widget _userDesc() {
    return Container(
      color: MyColor.primary[200],
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            SizedBox(
              height: 50,
              child: Center(
                child: Image.network(
                  currentUser!.photoURL.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  auth.currentUser!.displayName.toString(),
                  style: MyTextStyle.buttonText.copyWith(
                      color: MyColor.white, fontWeight: FontWeight.w900),
                ),
                Text(
                  auth.currentUser!.email.toString(),
                  style: MyTextStyle.buttonText.copyWith(
                      color: MyColor.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ],
            )
          ],
        ),
      ]),
    );
  }

  Widget _addClassButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
          onPressed: () {
            Get.toNamed("/landing/home/addClass");
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
          ),
          icon: Icon(Icons.add),
          label: Text(
            "클래스 개설하기",
            style: MyTextStyle.buttonText
                .copyWith(color: MyColor.white, fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget _header(String headerName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              headerName,
              style: MyTextStyle.buttonText.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<GestureDetector> _buildGridCards(RxList Classes) {
    if (Classes.isEmpty) {
      return const <GestureDetector>[];
    }
    return Classes.map((product) {
      return GestureDetector(
        onTap: (){
          Get.toNamed("/landing/classroom/class_room_screen", arguments: product);
        },
        child: Card(
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              leading: FutureBuilder<String>(
                  future: downloadURLExample(product.image),
                  // a previously-obtained Future<String> or null
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot1) {
                    if (snapshot1.hasData) {
                      return Image.network(snapshot1.data!, fit: BoxFit.fitWidth);
                    } else
                      return const CircularProgressIndicator();
                  }),
              title: Text(
                product.name,
                maxLines: 1,
                style:
                    MyTextStyle.buttonText.copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                product.description,
                maxLines: 1,
                style:
                MyTextStyle.buttonText.copyWith(fontWeight: FontWeight.w600, fontSize: 14 ),
              ),
            )),
      );
    }).toList();
  }
}

Future<String> downloadURLExample(String file) async {
  String downloadURL =
      await firebaseStorage.ref('${file}.jpeg').getDownloadURL();
  return downloadURL;
}
