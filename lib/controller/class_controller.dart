import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/models/classModel.dart';
import 'package:get/get.dart';

class ClassController extends GetxController{
  static ClassController instance = Get.find();
  var classList = <Class>[].obs;
  @override
  void onInit() {
    classList.bindStream(getClass());
    super.onInit();
  }

  Stream<List<Class>> getClass() {
    return firebaseFirestore.collection("class")
        .snapshots().map((value){
          return value.docs.map((element){
            return Class(
              name : element.data()['name'],
              category : element.data()['category'],
              price : element.data()['price'],
              description : element.data()['description'],
              location : element.data()['location'],
              date : element.data()['date'],
              image : element.data()['image'],
              author : element.data()['author'],
            );
          }
          ).toList();
    });
  }
}