import 'package:flutter/material.dart';
import 'package:flutter_blog/constants/button_style.dart';
import 'package:flutter_blog/constants/colors.dart';
import 'package:flutter_blog/constants/r.dart';
import 'package:flutter_blog/constants/strings.dart';
import 'package:flutter_blog/constants/style.dart';
import 'package:flutter_blog/routes/routes.dart';
import 'package:flutter_blog/util/keyboard_util.dart';
import 'package:flutter_blog/widget/logo_name_widget.dart';
import 'package:flutter_blog/widget/toolbar.dart';
import 'package:get/get.dart';

import 'login_controller.dart';
import 'widget/edit_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(R.assetsImagesLoginBackground),
                fit: BoxFit.cover)),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 60),
          ),
          const LogoNameWidget(),

          ///账户名输入框
          EditWidget(
              iconWidget: const Icon(
                Icons.perm_identity,
                color: Colors.white,
              ),
              hintText: StringStyles.loginAccountNameHint.tr,
              onChanged: (text) => controller..account.value = text),

          ///密码输入框
          EditWidget(
              iconWidget: const Icon(Icons.lock_open, color: Colors.white),
              hintText: StringStyles.loginAccountPwdHint.tr,
              passwordType: true,
              onChanged: (text) => controller..password.value = text),

          ///登录按钮
          Obx(() => Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(top: 36, left: 25, right: 25),
                decoration: BoxDecoration(
                  color: controller.changeShowButton()
                      ? ColorStyle.color_24CF5F
                      : ColorStyle.color_24CF5F_20,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                child: TextButton(
                    style: controller.changeShowButton()
                        ? ButtonStyles.getButtonStyle()
                        : ButtonStyles.getTransparentStyle(),
                    onPressed: () {
                      KeyboardUtils.hideKeyboard(context);
                      controller.login();
                    },
                    child: Text(
                      StringStyles.loginButton.tr,
                      style: controller.changeShowButton()
                          ? Styles.style_white_18
                          : Styles.style_white24_18,
                    )),
              )),

          ///注册按钮
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.only(top: 16, left: 25, right: 25),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: TextButton(
                style: ButtonStyles.getButtonStyle(),
                onPressed: () {
                  KeyboardUtils.hideKeyboard(context);
                  Get.toNamed(Routes.registerPage);
                },
                child: Text(
                  StringStyles.registerButton.tr,
                  style: Styles.style_white_18,
                )),
          )
        ]),
      ),
    );
  }
}
