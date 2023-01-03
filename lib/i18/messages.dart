import 'package:get/get.dart';
import 'en.dart';
import 'zh.dart';

//使用Get配置语言环境
class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'zh_CN': zh_CN, 'en_US': en_US};
}
