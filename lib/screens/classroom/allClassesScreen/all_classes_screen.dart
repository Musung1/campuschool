import 'package:campuschool/constants/controllerConstants.dart';
import 'package:campuschool/constants/global.dart';
import 'package:campuschool/model/class_model.dart';
import 'package:campuschool/screens/home/home.dart';
import 'package:campuschool/themes/color_theme.dart';
import 'package:campuschool/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllClassScreen extends StatelessWidget {
  const AllClassScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String category = "모든 클래스";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.primary[600],
        title: Text(category, style: MyTextStyle.centerTitle.copyWith(color: MyColor.white),),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Text("우리 학교에서 ${category} 선생님을 찾아보세요!", style: MyTextStyle.buttonText.copyWith(fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: Get.height,
              child: GridView.count(
                  crossAxisCount: 1,
                  children: classController.classList
                      .map((product) {
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 18 / 10,
                            child: FutureBuilder<String>(
                                future: downloadURLExample(product.image),
                                // a previously-obtained Future<String> or null
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot1) {
                                  if (snapshot1.hasData) {
                                    return Image.network(snapshot1.data!,
                                        fit: BoxFit.fitWidth);
                                  } else
                                    return const CircularProgressIndicator();
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  product.name,
                                  maxLines: 1,
                                  style: MyTextStyle.buttonText
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8.0),
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
                                SizedBox(height: 8),
                                Text(
                                  product.description,
                                  maxLines: 2,
                                  style: MyTextStyle.captionText.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: MyColor.darkSub2),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(child: Container()),
                                    GestureDetector(
                                      child: Text(
                                        "더보기  ",
                                        style: MyTextStyle.buttonText.copyWith(
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
                        ],
                      ),
                    );
                  }).toList()),
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
        height: 260,
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0,
          children: _buildGridCards(classController.classList),
        ),
      )
          : Container(),
    );
  }

  List<Card> _buildGridCards(List<Class> Classes) {
    if (Classes.isEmpty) {
      return const <Card>[];
    }
    return Classes.map((product) {
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
