import 'package:campuschool/controller/auth_controller.dart';
import 'package:campuschool/controller/landing_Controller.dart';
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
  }
}