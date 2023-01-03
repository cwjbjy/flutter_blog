import 'package:flutter_blog/i18/strings.dart';
import 'package:flutter_blog/http/repository.dart';
import 'package:flutter_blog/routes/routes.dart';
import 'package:flutter_blog/util/toast_util.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var account = ''.obs;
  var password = ''.obs;

  ///当前按钮是否可点击
  bool changeShowButton() {
    return account.isNotEmpty && password.isNotEmpty;
  }

  ///用户登录
  login() {
    if (account.isEmpty || password.isEmpty) {
      return;
    }

    ///账户名：>6位
    if (account.isEmpty || account.value.length < 6) {
      ToastUtils.show(account.isEmpty
          ? StringStyles.registerAccountEmpty.tr
          : StringStyles.registerAccountLength.tr);
      return;
    }

    ///密码：>6位
    if (password.isEmpty || password.value.length < 6) {
      ToastUtils.show(password.isEmpty
          ? StringStyles.registerPasswordEmpty.tr
          : StringStyles.registerPasswordLength.tr);
      return;
    }

    RequestRepository().login(account.value, password.value, success: (data) {
      ToastUtils.show(StringStyles.loginSuccess.tr);
      Get.offAllNamed(Routes.homePage);
    });
  }
}
