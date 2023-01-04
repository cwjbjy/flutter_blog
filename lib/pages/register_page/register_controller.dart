import 'package:get/get.dart';

class RegisterController extends GetxController {
  var isCheckPrivacy = true.obs;

  updateCheck() {
    isCheckPrivacy.value = !isCheckPrivacy.value;
  }
}
