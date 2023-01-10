import 'package:flutter/material.dart';
import 'package:flutter_blog/i18/strings.dart';
import 'package:flutter_blog/pages/home_page/home_controller.dart';
import 'package:flutter_blog/style/shadow_style.dart';
import 'package:flutter_blog/style/style.dart';
import 'package:flutter_blog/widget/head_circle_widget.dart';
import 'package:flutter_blog/widget/toolbar.dart';
import 'package:get/get.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ToolBar(
              title: StringStyles.homeUserInfo.tr, backOnTap: () => Get.back()),

          ///头像
          Container(
            margin: const EdgeInsets.only(top: 24),
            decoration: ShadowStyle.black12Circle40(),
            child: HeadCircleWidget(
              width: 72,
              height: 72,
            ),
          ),
          Box.vBox20,

          UserInfoWidget(
            keys: StringStyles.userNickname.tr,
            value: controller.userInfo.nickname,
          ),

          DividerStyle.divider1HalfPadding20,
        ],
      ),
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  String keys = "";
  String value = "";

  UserInfoWidget({
    Key? key,
    this.keys = "",
    this.value = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            keys,
            style: Styles.style_black_15,
          ),
          Text(
            value,
            style: Styles.style_black_15,
          ),
        ],
      ),
    );
  }
}
