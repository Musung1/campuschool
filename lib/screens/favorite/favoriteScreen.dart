import 'package:campuschool/constants/controllerConstants.dart';
import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/model/class_model.dart';
import 'package:campuschool/model/user_model.dart';
import 'package:campuschool/themes/color_theme.dart';
import 'package:campuschool/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "찜목록",
          style: MyTextStyle.centerTitle.copyWith(color: MyColor.white),
        ),
        backgroundColor: MyColor.primary[600],
        centerTitle: true,
      ),
      body: _bodyWidget()
    );
  }

  Widget _bodyWidget(){
    kUser currentUser = userController.userList
        .where((value) => value.uid == auth.currentUser!.uid)
        .first;
    classController.likedClasses.value = currentUser.likedClass
        .map((value) => classController.classList
        .where((element) => element.id == value)
        .first)
        .toList();
    return ListView(
      children: [
        _header("내가 찜한 클래스 목록"),
        _classesGrid(),
      ],
    );
  }
  Widget _header(String headerName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16,),
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
  Widget _classesGrid() {
    return Obx(
          () => !(classController.classList.isNullOrBlank)!
          ? Container(
        height: Get.height,
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0,
          children: _buildGridCards(classController.likedClasses),
        ),
      )
          : Container(),
    );
  }

  List<Card> _buildGridCards(RxList Classes) {
    if (Classes.isEmpty) {
      return const <Card>[];
    }
    return Classes.value.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: FutureBuilder<String>(
                  future: downloadURLExample(product.image),
                  // a previously-obtained Future<String> or null
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot1) {
                    if (snapshot1.hasData) {
                      return Image.network(snapshot1.data!,
                          fit: BoxFit.fitWidth);
                    } else
                      return const CircularProgressIndicator();
                  }),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name,
                      maxLines: 1,
                      style: MyTextStyle.buttonText
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        Text(
                          "가격   ",
                          style: MyTextStyle.captionText.copyWith(
                              fontWeight: FontWeight.w400,
                              color: MyColor.darkSub2),
                        ),
                        Text(
                          product.price,
                          maxLines: 2,
                          style: MyTextStyle.captionText.copyWith(
                              fontWeight: FontWeight.w400,
                              color: MyColor.darkSub2),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        GestureDetector(
                          child: Text(
                            "더보기",
                            style: MyTextStyle.captionText.copyWith(
                                fontWeight: FontWeight.bold,
                                color: MyColor.primary),
                          ),
                          onTap: () {
                            Get.toNamed('/landing/home/detailScreen',
                                arguments: product);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

Future<String> downloadURLExample(String file) async {
  String downloadURL =
  await firebaseStorage.ref('${file}.jpeg').getDownloadURL();
  return downloadURL;
}
