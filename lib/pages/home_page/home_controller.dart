import 'package:get/get.dart';
import 'package:flutter_blog/http/repository.dart';

class HomeController extends GetxController {
  banner() {
    RequestRepository.banner();
  }
}
