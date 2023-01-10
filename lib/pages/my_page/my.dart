import 'package:flutter/material.dart';
import 'package:flutter_blog/i18/strings.dart';
import 'package:flutter_blog/pages/home_page/home_controller.dart';
import 'package:flutter_blog/pages/my_page/widget/head_circle_widget.dart';
import 'package:flutter_blog/routes/routes.dart';
import 'package:flutter_blog/style/colors.dart';
import 'package:flutter_blog/style/shadow_style.dart';
import 'package:flutter_blog/style/style.dart';
import 'package:flutter_blog/widget/icon_text_widget.dart';
import 'package:get/get.dart';

import 'widget/title_content_widget.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: kTextTabBarHeight + 6),
      child: Column(
        children: [
          Row(
            children: [
              ///头像
              Container(
                margin: const EdgeInsets.only(left: 24),
                decoration: ShadowStyle.black12Circle40(),
                child: HeadCircleWidget(
                  width: 72,
                  height: 72,
                ),
              ),

              ///用户名称
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: GetBuilder<HomeController>(
                  builder: (_) => Text(
                    controller.userInfo.nickname,
                    style: Styles.style_1A2F51_18,
                  ),
                ),
              ),

              ///占位
              const Expanded(
                child: Text(''), // 中间用Expanded控件
              ),

              ///设置
              GestureDetector(
                onTap: () => Get.toNamed(Routes.settingPage),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Container(
                    color: ColorStyle.color_F3F3F3,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: const Icon(Icons.settings),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, left: 25, right: 25),
            decoration: ShadowStyle.white12Circle(),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              direction: Axis.horizontal,
              children: [
                ///收藏数量
                Expanded(
                  flex: 1,
                  child: GetBuilder<HomeController>(
                    builder: (_) => TitleContentWidget(
                      title: StringStyles.homeCollect.tr,
                      content: controller.userInfo.collectIds.length.toString(),
                    ),
                  ),
                ),

                ///积分
                Expanded(
                  flex: 1,
                  child: GetBuilder<HomeController>(
                    builder: (_) => TitleContentWidget(
                      title: StringStyles.homePoints.tr,
                      content: controller.userInfo.coinCount.toString(),
                    ),
                  ),
                ),

                ///历史
                Expanded(
                    flex: 1,
                    child: Obx(() => TitleContentWidget(
                          title: StringStyles.homeHistory.tr,
                          content: '${controller.browseHistory.value}',
                        ))),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 16, left: 25, right: 25),
            decoration: ShadowStyle.white12Circle(),
            child: Column(children: [
              ///个人信息
              IconTitleWidget(
                icon: Icons.perm_identity,
                text: StringStyles.homeUserInfo.tr,
                endColor: Colors.black54,
                onTap: () => Get.toNamed(Routes.userInfoPage),
              ),

              // ///关于
              IconTitleWidget(
                icon: Icons.info_outline,
                text: StringStyles.homeAbout.tr,
                endColor: Colors.black54,
                onTap: () => Get.toNamed(Routes.aboutPage),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
