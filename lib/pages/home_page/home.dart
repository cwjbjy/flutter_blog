import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blog/i18/strings.dart';
import 'package:flutter_blog/pages/composite_page/composite.dart';
import 'package:flutter_blog/pages/my_page/my.dart';
import 'package:flutter_blog/pages/project_page/project.dart';
import 'package:flutter_blog/style/colors.dart';
import 'package:flutter_blog/style/shadow_style.dart';
import 'package:flutter_blog/widget/dialog/dialog_share_article.dart';
import 'package:flutter_blog/widget/keepAlive.dart';
import 'package:get/get.dart';

import 'home_controller.dart';
import 'widget/home_tab_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  //tab控制器
  late TabController tabController;

  ///监听 应用从后台切换到前台时，读取粘贴板中的数据，验证URL，已保存分享
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      var clipboardData = Clipboard.getData(Clipboard.kTextPlain);
      clipboardData.then((value) {
        debugPrint("clipboardData=> ${value?.text}");
        if (value != null &&
            value.text != null &&
            value.text!.isNotEmpty &&
            (value.text!.startsWith("https://") ||
                value.text!.startsWith("http://"))) {
          Get.dialog(ShareArticleDialog(url: value.text!));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addObserver(this); //注册监听器

    tabController.addListener(() {
      //监听Tab切换事件
      // debugPrint(tabController.index.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: ColorStyle.color_F8F9FC,
      body: TabBarView(
        controller: tabController,
        children: const [
          KeepAliveWrapper(child: CompositePage()),
          KeepAliveWrapper(child: ProjectPage()),
          KeepAliveWrapper(child: MyPage())
        ],
      ),
      bottomNavigationBar: Container(
        height: 65,
        decoration: ShadowStyle.white12TopSpread4Blur10(radius: 0),
        child: TabBar(
          indicator: const BoxDecoration(),
          labelColor: ColorStyle.color_24CF5F,
          unselectedLabelColor: ColorStyle.color_B8C0D4,
          controller: tabController,
          tabs: [
            TabTitleIcon(
              title: StringStyles.homeComplex.tr,
              icon: Icons.turned_in,
            ),
            TabTitleIcon(
              title: StringStyles.homeProject.tr,
              icon: Icons.send,
            ),
            TabTitleIcon(
              title: StringStyles.homeMy.tr,
              icon: Icons.person,
            ),
          ],
        ),
      ),
    );
  }
}
