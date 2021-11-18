import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/model/class_model.dart';
import 'package:campuschool/themes/color_theme.dart';
import 'package:campuschool/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Get.toNamed('/landing/home/profile');
            }),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Get.toNamed('/landing/home/search');
              }),
        ],
        title: Text("캠퍼스쿨"),
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _banner(),
          _categoryList(),
          _header("우리 캠퍼스안! 클래스"),
          _classesGrid(),
        ],
      ),
    );
  }

  Widget _banner() {
    return Container(
      color: MyColor.primary[200],
      width: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "우리 학교에서\n기타 선생님 찾기",
              style: MyTextStyle.buttonText
                  .copyWith(fontWeight: FontWeight.bold, color: MyColor.white),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "나만의 악기선생님 모음집",
                    style: MyTextStyle.buttonText.copyWith(
                        fontWeight: FontWeight.w400, color: MyColor.white),
                  ),
                ),
                Icon(
                  Icons.music_note_rounded,
                  color: MyColor.white,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryList() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _category(Icon(Icons.mic_external_on), "보컬"),
              _category(Icon(Icons.music_note), "악기"),
              _category(Icon(Icons.lunch_dining), "요리"),
              _category(Icon(Icons.directions_run), "운동"),
            ],
          ),
          SizedBox(height: 32,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _category(Icon(Icons.personal_video), "코딩"),
              _category(Icon(Icons.camera_alt), "촬영"),
              _category(Icon(Icons.accessibility_new), "운동"),
              _category(Icon(Icons.star), "인기"),
            ],
          ),
        ],
      )),
    );
  }

  Widget _category(Icon icon, String name) {
    return GestureDetector(
      child: Column(
        children: [
          icon,
          SizedBox(height: 8,),
          Text(
            name,
            style: MyTextStyle.buttonText.copyWith(fontWeight: FontWeight.w700, fontSize: 14, color: MyColor.darkSub),
          )
        ],
      ),
    );
  }
  Widget _header(String headerName){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(headerName,
              style: MyTextStyle.buttonText.copyWith(fontWeight: FontWeight.w900, fontSize: 18, ),
            ),
          ),
          Icon(Icons.keyboard_arrow_right, color: MyColor.darkSub, size: 32,),
        ],
      ),
    );
  }
  Widget _classesGrid() {
    return StreamBuilder<List<Class>>(
        stream: getClass(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Container(
              height: 260,
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16.0),
                childAspectRatio: 8.0 / 9.0,
                children: _buildGridCards(snapshot.data!),
              ),
            );
          }
          else return CircularProgressIndicator();
        });
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
                  future: downloadURLExample(product.image), // a previously-obtained Future<String> or null
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
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      product.price,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 10),
                    ),
                    Expanded(
                      child: TextButton(
                        child: const Text("더보기"),
                        onPressed: () {
                          Get.toNamed('/landing/home/detailScreen', arguments: product );
                        },
                      ),
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
        id : element.id.toString()
      );
    }
    ).toList();
  });
}
}

Future<String> downloadURLExample(String file) async {
  String downloadURL = await firebaseStorage
      .ref('${file}.jpeg')
      .getDownloadURL();
  return downloadURL;
}