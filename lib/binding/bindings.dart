import 'package:campuschool/controller/add_class_controller.dart';
import 'package:campuschool/controller/assignment_controller.dart';
import 'package:campuschool/controller/auth_controller.dart';
import 'package:campuschool/controller/class_controller.dart';
import 'package:campuschool/controller/landing_controller.dart';
import 'package:campuschool/controller/user_controller.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
class LandingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandingController());
    Get.lazyPut(() => ClassController());
    Get.lazyPut(() => UserController());
  }
}
class AddClassBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddClassController());
  }
}
class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClassController());
  }
}
class ClassRoomBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddClassController());
  }
}
