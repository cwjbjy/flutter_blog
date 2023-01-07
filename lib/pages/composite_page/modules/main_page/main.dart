import 'package:flutter/material.dart';
import 'package:flutter_blog/constants/r.dart';
import 'package:flutter_blog/http/repository.dart';
import 'package:flutter_blog/model/banner_mode.dart';
import 'package:flutter_blog/routes/routes.dart';
import 'package:flutter_blog/util/web_util.dart';
import 'package:get/get.dart';

import 'widget/banner_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ///首页Banner轮播图
  List<Banners> banner = [];

  @override
  void initState() {
    super.initState();
    getBanner();
  }

  void getBanner() {
    RequestRepository.getBanner(success: (data) {
      ///添加自定义的积分排行榜图片
      banner.add(Banners(
        imagePath: R.assetsIntegralRanking,
        isAssets: true,
      ));
      banner.addAll(data);
      setState(() {});

      ///预缓存banner图片
      for (var element in data) {
        precacheImage(NetworkImage(element.imagePath), context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          top: true,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                width: double.infinity,
                height: 140,
                child: BannerWidget(
                  banner,
                  height: 140,
                  onTap: (index) {
                    if (index == 0) {
                      Get.toNamed(Routes.rankingPage);
                    } else {
                      WebUtil.toWebPageBanners(banner[index]);
                    }
                  },
                ),
              ),
              // Expanded(
              //     child: RefreshWidget(
              //         child: ListView.builder(
              //   padding: EdgeInsets.zero,
              //   shrinkWrap: true,
              //   itemCount: controller.projectData.length +
              //       1 +
              //       (controller.insertIndex == -1 ? 0 : 1),
              //   itemBuilder: (BuildContext context, int index) {
              //     ///将Banner装载到ListView中
              //     if (index == 0) {
              //     } else if (index == controller.insertIndex) {
              //       ///随机出现的公众号列表
              //       return Obx(() => WechatPublicWidget(
              //             isFirst: controller.isFirst,
              //             wechatPublic: controller.showWechatPublic,
              //             onChange: () => controller.notifyRandomPublic(),
              //             showSwitch: controller.showSwitch.value,
              //             showDelete: controller.showDelete.value,
              //             onTap: () => controller.notifyButtonState(),
              //           ));
              //     } else {
              //       ///计算当前显示的真实索引
              //       var newIndex = index -
              //           (index > controller.insertIndex &&
              //                   controller.insertIndex != -1
              //               ? 2
              //               : 1);

              //       ///item列表数据展示
              //       return Material(
              //         color: Colors.transparent,
              //         child: Ripple(
              //             onTap: () => WebUtil.toWebPage(
              //                     controller.projectData[newIndex],
              //                     onResult: (value) {
              //                   controller.projectData[newIndex].collect =
              //                       value;
              //                 }),
              //             child: MainArticleItem(
              //               item: controller.projectData[newIndex],
              //               index: newIndex,
              //             )),
              //       );
              //     }
              //   },
              // )))
            ],
          )),
    );
  }
}
