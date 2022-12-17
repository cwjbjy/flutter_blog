import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @description :初始化时进行依赖注入，可全局使用
class Injection{

  static Future<void> init() async {
    // 数据存储实例存入Get中，方便全局调用
    await Get.putAsync(() => SharedPreferences.getInstance());
  }
}