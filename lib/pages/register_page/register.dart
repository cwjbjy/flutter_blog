import 'package:flutter/material.dart';
import 'package:flutter_blog/constants/r.dart';
import 'package:flutter_blog/http/repository.dart';
import 'package:flutter_blog/i18/strings.dart';
import 'package:flutter_blog/routes/routes.dart';
import 'package:flutter_blog/style/button_style.dart';
import 'package:flutter_blog/style/colors.dart';
import 'package:flutter_blog/style/style.dart';
import 'package:flutter_blog/util/keyboard_util.dart';
import 'package:flutter_blog/util/toast_util.dart';
import 'package:flutter_blog/widget/edit_widget.dart';
import 'package:flutter_blog/widget/logo_name_widget.dart';
import 'package:flutter_blog/widget/toolbar.dart';
import 'package:get/get.dart';

import 'register_controller.dart';
import 'widget/registerPrivacyWidget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String account = '';
  String password = '';
  String rePassword = '';

  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(R.assetsImagesLoginBackground),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ToolBar(
                    backColor: Colors.white,
                    backOnTap: () => Get.back(),
                    backgroundColor: Colors.transparent,
                  ),

                  ///logo及app名称
                  const LogoNameWidget(),

                  ///账户名输入框
                  EditWidget(
                    iconWidget: const Icon(
                      Icons.perm_identity,
                      color: Colors.white,
                    ),
                    hintText: StringStyles.loginAccountNameHint.tr,
                    onChanged: (text) => setState(() {
                      account = text;
                    }),
                  ),

                  ///密码输入框
                  EditWidget(
                    iconWidget:
                        const Icon(Icons.lock_open, color: Colors.white),
                    hintText: StringStyles.loginAccountPwdHint.tr,
                    passwordType: true,
                    onChanged: (text) => setState(() {
                      password = text;
                    }),
                  ),

                  ///再次输入密码输入框
                  EditWidget(
                    iconWidget:
                        const Icon(Icons.lock_open, color: Colors.white),
                    hintText: StringStyles.loginAccountRePwdHint.tr,
                    passwordType: true,
                    onChanged: (text) => setState(() {
                      rePassword = text;
                    }),
                  ),

                  ///用户服务条款
                  const RegisterPrivacyWidget(),

                  ///注册按钮
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.only(top: 16, left: 25, right: 25),
                    decoration: BoxDecoration(
                      color: _changeShowButton()
                          ? ColorStyle.color_24CF5F
                          : ColorStyle.color_24CF5F_20,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: TextButton(
                        style: _changeShowButton()
                            ? ButtonStyles.getButtonStyle()
                            : ButtonStyles.getTransparentStyle(),
                        onPressed: () {
                          KeyboardUtils.hideKeyboard(context);
                          _register();
                        },
                        child: Text(
                          StringStyles.registerButton.tr,
                          style: _changeShowButton()
                              ? Styles.style_white_18
                              : Styles.style_white24_18,
                        )),
                  ),
                ],
              ),
            )));
  }

  ///当前按钮是否可点击
  bool _changeShowButton() {
    return account.isNotEmpty && password.isNotEmpty && rePassword.isNotEmpty;
  }

  //点击注册
  // 注册成功跳转
  void _register() {
    if (account.isEmpty || password.isEmpty || rePassword.isEmpty) {
      return;
    }

    ///账户名：>6位
    if (account.isEmpty || account.length < 6) {
      ToastUtils.show(account.isEmpty
          ? StringStyles.registerAccountEmpty.tr
          : StringStyles.registerAccountLength.tr);
      return;
    }

    ///密码：>6位
    if (password.isEmpty || password.length < 6) {
      ToastUtils.show(password.isEmpty
          ? StringStyles.registerPasswordEmpty.tr
          : StringStyles.registerPasswordLength.tr);
      return;
    }

    ///确认密码：>6位
    if (rePassword.isEmpty || rePassword.length < 6) {
      ToastUtils.show(rePassword.isEmpty
          ? StringStyles.registerRePasswordEmpty.tr
          : StringStyles.registerRePasswordLength.tr);
      return;
    }

    ///密码 == 确认密码
    if (password != rePassword) {
      ToastUtils.show(StringStyles.registerPasswordDiff.tr);
      return;
    }

    ///同意服务条款
    if (!controller.isCheckPrivacy.value) {
      ToastUtils.show(StringStyles.registerNotServiceTerms.tr);
      return;
    }

    RequestRepository.register(account, password, rePassword, success: (data) {
      ToastUtils.show(StringStyles.registerSuccess.tr);
      Get.offAllNamed(Routes.homePage);
    });
  }
}
