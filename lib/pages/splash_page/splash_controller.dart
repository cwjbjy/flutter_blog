import 'package:get/get.dart';

class SplashController extends GetxController {
  var opacityLevel = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 200), () {
      opacityLevel.value = 1.0;
    });
  }
}
