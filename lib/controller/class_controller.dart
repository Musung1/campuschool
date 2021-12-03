import 'package:campuschool/constants/firebaseConstants.dart';
import 'package:campuschool/model/class_model.dart';
import 'package:get/get.dart';

class ClassController extends GetxController{
  static ClassController instance = Get.find();
  var classList = <Class>[].obs;
  RxList takedClasses = [].obs;
  RxList myClasses = [].obs;
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
          id: element.id.toString(),
          name : element.data()['name'].toString(),
          category : element.data()['category'].toString(),
          price : element.data()['price'].toString(),
          description : element.data()['description'].toString(),
          location : element.data()['location'].toString(),
          date : element.data()['date'].toString(),
          image : element.data()['image'].toString(),
          author : element.data()['author'].toString(),
          history : element.data()['history'].toString(),
          latitude : element.data()['latitude'].toString(),
          longitude : element.data()['longitude'].toString(),
        );
      }
      ).toList();
    });
  }
}