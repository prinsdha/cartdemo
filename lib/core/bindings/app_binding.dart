import 'package:get/get.dart';
import 'package:interviewtask/ui/screens/auth/controller/auth_controller.dart';
import 'package:interviewtask/ui/screens/home/controller/cart_controller.dart';
import 'package:interviewtask/ui/screens/home/controller/home_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
  }
}
